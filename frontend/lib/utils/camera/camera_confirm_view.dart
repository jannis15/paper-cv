part of 'camera_utils.dart';

enum _SaveImageState { savable, saving, saved }

class _CameraConfirmView extends StatefulWidget {
  final SelectedFile image;

  const _CameraConfirmView({required this.image});

  @override
  State<_CameraConfirmView> createState() => _CameraConfirmViewState();
}

class _CameraConfirmViewState extends State<_CameraConfirmView> {
  TransformationController _transformationController = TransformationController();
  _SaveImageState _saveImageState = _SaveImageState.savable;
  late final Uint8List _imageBytes;

  void _loadImage() {
    _imageBytes = widget.image.data;
  }

  Future<AlertOption?> _showAppSettingsDialog() async {
    final AlertOption? result = await showAlertDialog(context,
        title: 'Zugriff verweigert',
        content: 'Die App benötigt die Berechtigung, um Fotos in der Galerie speichern zu können.',
        optionData: [AlertOptionData.yes(customText: 'Einstellungen öffnen')]);
    if (result != null && result == AlertOption.yes) {
      openAppSettings();
    }
    return result;
  }

  Future<bool> _saveImage() async {
    _saveImageState = _SaveImageState.saving;
    setState(() {});
    bool result = false;
    try {
      if (kIsWeb) {
        final now = DateTime.now();
        accessFile(SelectedFile(filename: 'download.jpg', data: _imageBytes, createdAt: now, modifiedAt: now));
        _saveImageState = _SaveImageState.saved;
      } else {
        if (await Gal.requestAccess(toAlbum: true)) {
          try {
            await Gal.putImageBytes(_imageBytes);
            _saveImageState = _SaveImageState.saved;
            result = true;
          } on GalException catch (e) {
            if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.type.code}: ${e.type.message}')));
            _saveImageState = _SaveImageState.savable;
          }
        } else {
          _saveImageState = _SaveImageState.savable;
          if (mounted) await _showAppSettingsDialog();
        }
      }
    } catch (_) {
      _saveImageState = _SaveImageState.savable;
    }
    if (mounted) setState(() {});
    return result;
  }

  Widget _getImageStateIcon() {
    if (_saveImageState == _SaveImageState.savable) {
      return const Icon(Icons.save_alt);
    } else if (_saveImageState == _SaveImageState.saving) {
      return const SizedBox(
          width: 24, height: 24, child: Padding(padding: EdgeInsets.all(3), child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)));
    } else {
      return const Icon(Icons.check);
    }
  }

  Widget _getImageStateText() {
    if ([_SaveImageState.savable, _SaveImageState.saving].contains(_saveImageState)) {
      return const Text('Speichern');
    } else {
      return const Text('Gespeichert');
    }
  }

  Future<void> _onConfirm() async {
    if (mounted) Navigator.of(context).pop<bool>(true);
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  InteractiveViewer(transformationController: _transformationController, maxScale: 8, child: Image.memory(_imageBytes)),
                  Positioned(
                    left: 10,
                    bottom: 0,
                    child: FilledButton.icon(
                      style: ButtonStyle(
                        elevation: const WidgetStatePropertyAll(0),
                        foregroundColor: const WidgetStatePropertyAll(Colors.white),
                        backgroundColor: WidgetStatePropertyAll(Colors.black.withOpacity(.3)),
                      ),
                      onPressed: _saveImageState == _SaveImageState.savable
                          ? () async {
                              await _saveImage();
                            }
                          : null,
                      icon: _getImageStateIcon(),
                      label: _getImageStateText(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: RowGap(
                gap: 10,
                children: [
                  Expanded(child: FilledButton(onPressed: () => Navigator.of(context).pop<bool>(false), child: const Text('Wiederholen'))),
                  Expanded(child: FilledButton(onPressed: () => _onConfirm(), child: const Text('OK')))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
