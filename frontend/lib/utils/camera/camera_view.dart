part of 'camera_utils.dart';

class _CameraView extends StatefulWidget {
  final bool allowGalleryPictures;
  final bool allowMultiple;
  final double? aspectRatioOverlay;

  const _CameraView({
    required this.allowGalleryPictures,
    required this.allowMultiple,
    this.aspectRatioOverlay,
  }) : assert(aspectRatioOverlay != null && aspectRatioOverlay >= 1, 'The aspect ratio overlay needs to be equal or above 1');

  @override
  State<_CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<_CameraView> {
  double? _cameraLayoutHeight;
  CameraController? _cameraController;
  CameraLensDirection _currentLensDirection = CameraLensDirection.back;
  bool _hasPermissionError = false;
  bool _takingPicture = false;
  bool _swappingCamera = false;
  bool _pickingFromGallery = false;
  int _numberAvailableDirections = 0;

  CameraLensDirection get oppositeLensDirection =>
      _currentLensDirection == CameraLensDirection.front ? CameraLensDirection.back : CameraLensDirection.front;

  bool get _isPerformingAction => (_pickingFromGallery || _takingPicture || _swappingCamera);

  Future<CameraDescription?> _getDesiredCamera(CameraLensDirection direction) async {
    _currentLensDirection = direction;
    final List<CameraDescription> cameras = await availableCameras();
    _numberAvailableDirections = cameras.map((camera) => camera.lensDirection).toSet().length;
    return cameras.where((element) => element.lensDirection == direction).firstOrNull ?? cameras.firstOrNull;
  }

  Future<void> _initCameraController({bool useOppositeLensDirection = false}) async {
    final camera = await _getDesiredCamera(useOppositeLensDirection ? oppositeLensDirection : _currentLensDirection);
    if (camera == null) return;
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    try {
      await _cameraController!.initialize();
      try {
        await _cameraController!.setFlashMode(FlashMode.off);
      } catch (_) {}
      if (mounted) setState(() {});
    } on CameraException catch (_) {
      await _disableCameraController();
      _hasPermissionError = true;
    }
    if (mounted) setState(() {});
  }

  Future<void> _disableCameraController() async {
    await _cameraController?.dispose();
    _cameraController = null;
  }

  Future<void> _pickFromGallery() async {
    if (_isPerformingAction) return;

    await _disableCameraController();
    setState(() {
      _pickingFromGallery = true;
    });
    try {
      final List<SelectedFile> images = [];
      try {
        if (widget.allowMultiple) {
          final selectedFiles = await Future.wait(
            (await ImagePicker().pickMultiImage()).map(
              (xFile) async {
                final fileBytes = await xFile.readAsBytes();
                final now = DateTime.now();
                return SelectedFile(
                  filename: xFile.name,
                  data: fileBytes,
                  createdAt: now,
                  modifiedAt: now,
                );
              },
            ),
          );
          images.addAll((selectedFiles));
        } else {
          final image = await ImagePicker().pickImage(source: ImageSource.gallery);
          if (image != null) {
            final fileBytes = await image.readAsBytes();
            final now = DateTime.now();
            final selectedFile = SelectedFile(
              filename: image.name,
              data: fileBytes,
              createdAt: now,
              modifiedAt: now,
            );
            images.add(selectedFile);
          }
        }
        if (images.isEmpty) {
          await _initCameraController();
        } else {
          if (mounted) Navigator.of(context).pop<List<SelectedFile>>(images);
        }
      } on PlatformException catch (_) {
        if (mounted) {
          final AlertOption? result = await showAlertDialog(
            context,
            title: 'Zugriff verweigert',
            content: 'Die App benötigt die Berechtigung, um Fotos aus Ihrer Galerie nutzen zu können',
            optionData: [AlertOptionData.yes(customText: 'Einstellungen öffnen')],
            barrierDismissible: true,
          );
          if (result != null && result == AlertOption.yes) {
            openAppSettings();
          }
        }
      }
    } finally {
      _pickingFromGallery = false;
    }
  }

  Future<void> _takePicture() async {
    if (_isPerformingAction) return;
    if (_cameraLayoutHeight == null) return;

    setState(() {
      _takingPicture = true;
    });
    try {
      final XFile image = await _cameraController!.takePicture();

      // rotate image
      late final int rotationAngle;
      try {
        final orientation = await OrientationHelper.getCameraOrientation();
        rotationAngle = OrientationHelper.getRotationAngle(orientation);
      } catch (_) {
        rotationAngle = 0;
      }
      late final img.Image rotatedImage;
      final imageBytes = await image.readAsBytes();
      final originalImage = img.decodeImage(imageBytes)!;
      if (rotationAngle != 0) {
        rotatedImage = img.copyRotate(originalImage, angle: rotationAngle);
      } else {
        rotatedImage = originalImage;
      }

      // crop image
      final finalToPreviewFactor = rotatedImage.height / _cameraLayoutHeight!;
      final int cropHeight = (rotatedImage.height - ((cameraFeedOverlayMargin * 2) * finalToPreviewFactor)).round();
      final int cropWidth = (cropHeight * (1 / widget.aspectRatioOverlay!)).round();
      final croppedImage = img.copyCrop(
        rotatedImage,
        x: ((rotatedImage.width / 2) - (cropWidth / 2)).round(),
        y: (cameraFeedOverlayMargin * finalToPreviewFactor).round(),
        width: cropWidth,
        height: cropHeight,
      );
      final now = DateTime.now();
      final selectedFile = SelectedFile(
        filename: image.name,
        data: img.encodeJpg(croppedImage),
        createdAt: now,
        modifiedAt: now,
      );

      if (mounted) {
        bool? isAccepted = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (context) => _CameraConfirmView(image: selectedFile)));
        if (isAccepted != null && isAccepted) {
          if (mounted) Navigator.of(context).pop<List<SelectedFile>>([selectedFile]);
        } else {
          if (mounted) setState(() {});
        }
      }
    } finally {
      _takingPicture = false;
    }
  }

  Future<void> _swapCamera() async {
    if (_isPerformingAction) return;

    setState(() {
      _swappingCamera = true;
    });
    try {
      await _initCameraController(useOppositeLensDirection: true);
    } finally {
      _swappingCamera = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _asyncInit();
  }

  Future<void> _asyncInit() async {
    await WakelockPlus.enable();
    await _initCameraController();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _disableCameraController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildActions() => [
          SizedBox(
            height: AppSizes.kComponentHeight + AppSizes.kGap,
            width: AppSizes.kComponentHeight + AppSizes.kGap,
            child: widget.allowGalleryPictures
                ? IconButton(
                    tooltip: 'Galerie öffnen',
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.perm_media,
                      color: Colors.white,
                      size: AppSizes.kIconButtonSize,
                    ),
                    onPressed: _pickFromGallery,
                  )
                : null,
          ),
          !_hasPermissionError
              ? _takingPicture
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : Container(
                      padding: const EdgeInsets.all(AppSizes.kMinInputGap),
                      decoration: const ShapeDecoration(shape: CircleBorder(side: BorderSide(color: Colors.white))),
                      child: SizedBox(
                        height: AppSizes.kComponentHeight + AppSizes.kGap,
                        width: AppSizes.kComponentHeight + AppSizes.kGap,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: AppSizes.kIconButtonSize,
                          ),
                          onPressed: _takePicture,
                        ),
                      ),
                    )
              : SizedBox(),
          SizedBox(
            height: AppSizes.kComponentHeight + AppSizes.kGap,
            width: AppSizes.kComponentHeight + AppSizes.kGap,
            child: !_hasPermissionError && _numberAvailableDirections > 1
                ? IconButton(
                    tooltip: 'Kamera wechseln',
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.cameraswitch,
                      color: Colors.white,
                      size: AppSizes.kIconButtonSize,
                    ),
                    onPressed: _cameraController?.value.isTakingPicture ?? true ? null : _swapCamera,
                  )
                : null,
          ),
        ];

    return PopScope(
      canPop: !_isPerformingAction,
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) => Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              if (_hasPermissionError)
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Kamera-Zugriff verweigert', textAlign: TextAlign.center),
                        FilledButton.icon(
                          onPressed: () {
                            openAppSettings();
                          },
                          icon: const Icon(Icons.settings),
                          label: const Text('App-Einstellungen öffnen'),
                        ),
                        FilledButton.icon(
                          onPressed: () async {
                            _hasPermissionError = false;
                            setState(() {});
                            WidgetsBinding.instance.addPostFrameCallback((_) async {
                              await _initCameraController();
                            });
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Erneut versuchen'),
                        ),
                      ],
                    ),
                  ),
                ),
              if (!_hasPermissionError && _cameraController != null)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CameraPreview(
                      _cameraController!,
                      child: widget.aspectRatioOverlay != null
                          ? LayoutBuilder(
                              builder: (context, constraints) {
                                _cameraLayoutHeight = constraints.maxHeight;
                                return CustomPaint(
                                  size: Size(
                                    constraints.maxWidth,
                                    constraints.maxHeight,
                                  ),
                                  painter: CameraRectangularOverlayPainter(
                                    context,
                                    aspectRatio: widget.aspectRatioOverlay!,
                                  ),
                                );
                              },
                            )
                          : null,
                    ),
                  ],
                ),
              Positioned(
                top: AppSizes.kGap,
                left: AppSizes.kGap,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.kSmallGap),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: BorderRadius.circular(AppSizes.kComponentHeight + AppSizes.kGap),
                    ),
                    child: SizedBox(
                      height: AppSizes.kComponentHeight + AppSizes.kGap,
                      width: AppSizes.kComponentHeight + AppSizes.kGap,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        tooltip: 'Zurück',
                        onPressed: () {
                          if (!_isPerformingAction) Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          size: AppSizes.kIconButtonSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: orientation == Orientation.portrait ? AppSizes.kGap : null,
                top: orientation == Orientation.portrait ? null : AppSizes.kGap,
                right: AppSizes.kGap,
                bottom: AppSizes.kGap,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.kSmallGap),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: BorderRadius.circular(AppSizes.kComponentHeight + AppSizes.kGap),
                    ),
                    child: SizedBox(
                      height: orientation == Orientation.portrait ? AppSizes.kComponentHeight + AppSizes.kGap : null,
                      width: orientation == Orientation.portrait ? null : AppSizes.kComponentHeight + AppSizes.kGap,
                      child: Flex(
                        direction: orientation == Orientation.portrait ? Axis.horizontal : Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: orientation == Orientation.portrait ? buildActions() : buildActions().reversed.toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
