import 'dart:async';
import 'dart:ui' as ui show Image;
import 'package:collection/collection.dart';
import 'package:file_icon/file_icon.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/components/floor_icon_button.dart';
import 'package:paper_cv/components/floor_icon_with_background.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/alert_dialog.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:paper_cv/utils/image_utils.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/string_extension.dart';
import 'package:paper_cv/utils/ui_image_extension.dart';
import 'package:paper_cv/utils/widget_utils.dart';
import "package:flutter/material.dart";
import 'package:paper_cv/utils/mobile_access_file.dart' if (dart.library.html) 'package:paper_cv/utils/web_access_file.dart';

import '../generated/l10n.dart';

class FloorAttachmentCard extends StatefulWidget {
  final String title;
  final List<SelectedFile> files;
  final Future<List<SelectedFile>?> Function() onPickFiles;
  final Future<List<SelectedFile>?> Function()? onPickFiles2;
  final FutureOr<void> Function(List<SelectedFile> files) onAddFiles;
  final FutureOr<void> Function(SelectedFile file, int idx) onRemoveFile;
  final FutureOr<void> Function(SelectedFile file, int idx, ui.Image? image)? onTapFile;
  final Widget Function(SelectedFile file)? fileStatusWidget;
  final IconData iconData;
  final IconData? iconData2;
  final String iconText;
  final bool disablePickFile;
  final Widget? infoWidget;

  FloorAttachmentCard({
    super.key,
    required this.title,
    required this.files,
    required this.onPickFiles,
    this.onPickFiles2,
    required this.onAddFiles,
    required this.onRemoveFile,
    this.onTapFile,
    this.fileStatusWidget,
    this.disablePickFile = false,
    this.iconData = Icons.add,
    this.iconData2,
    String? iconText,
    this.infoWidget,
  })  : assert((iconData2 == null && onPickFiles2 == null) || (iconData2 != null && onPickFiles2 != null), 'FloorAttachmentCard wrong parameters!'),
        iconText = iconText ?? S.current.add;

  @override
  State<FloorAttachmentCard> createState() => FloorAttachmentCardState();
}

class FloorAttachmentCardState extends State<FloorAttachmentCard> {
  final List<ui.Image?> _previewImages = [];
  late final List<SelectedFile> _files;
  bool _isLoading = true;
  bool _isAttaching = false;

  @override
  void initState() {
    super.initState();
    _asyncInit();
  }

  void _asyncInit() async {
    _files = widget.files;
    try {
      await _addPreviewImages(_files);
    } finally {
      _isLoading = false;
      if (mounted) setState(() {});
    }
  }

  Future<void> _addPreviewImages(List<SelectedFile> files) async {
    for (final file in files) {
      ui.Image? tmpImage;
      if (ImageUtils.isImage(file.data)) {
        tmpImage = await decodeImageFromList(file.data);
      }
      _previewImages.add(tmpImage);
    }
  }

  Future<void> onPickFilesButtonPress(Future<List<SelectedFile>?> Function() onPickFiles) async {
    _isAttaching = true;
    setState(() {});
    try {
      final newFiles = await onPickFiles();
      if (newFiles != null) {
        _files.addAll(newFiles);
        await _addPreviewImages(newFiles);
        widget.onAddFiles(newFiles);
      }
    } finally {
      _isAttaching = false;
      if (context.mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    const double kRatio = 21 / 29.7;
    const double kAntiRatio = 1 / kRatio;
    const double kMaxHeight = 150.0;
    Widget buildFilePreview(int index) {
      final ui.Image? previewImage = _previewImages[index];
      final SelectedFile file = _files[index];
      return Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: widget.onTapFile != null ? () => widget.onTapFile!(file, index, _previewImages[index]) : () => accessFile(file),
            child: Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.only(
                top: AppSizes.kIconButtonSize / 2,
                right: AppSizes.kIconButtonSize / 2,
              ),
              width: previewImage != null
                  ? previewImage.isLandscape
                      ? kMaxHeight * kAntiRatio
                      : kMaxHeight * kRatio
                  : kMaxHeight * kRatio,
              height: kMaxHeight,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.all(Radius.circular(AppSizes.kBorderRadius)),
              ),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: previewImage != null
                    ? FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        child: RawImage(image: previewImage),
                      )
                    : IconWithBackground(
                        iconWidget: FileIcon(file.filename, size: 64),
                        text: file.filename.removeFileExtension(),
                      ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: FloorIconButton(
              iconData: Icons.close,
              foregroundColor: colorScheme.onPrimaryContainer,
              backgroundColor: colorScheme.primaryContainer,
              onPressed: () async {
                final alertResult = await showAlertDialog(
                  context,
                  title: S.current.removeFile(file.filename),
                  optionData: [
                    AlertOptionData.cancel(),
                    AlertOptionData.yes(customText: S.current.remove),
                  ],
                );
                if (alertResult == AlertOption.yes) {
                  _files.removeAt(index);
                  _previewImages.removeAt(index);
                  await widget.onRemoveFile(file, index);
                  if (context.mounted) setState(() {});
                }
              },
            ),
          ),
          if (widget.fileStatusWidget != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: IgnorePointer(
                child: widget.fileStatusWidget!(file),
              ),
            ),
        ],
      );
    }

    return FloorCard(
      child: ColumnGap(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: AppSizes.kSmallGap,
        children: [
          RowGap(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            gap: AppSizes.kSmallGap,
            children: [
              Flexible(
                child: RowGap(
                  gap: AppSizes.kSmallGap,
                  children: [
                    Flexible(
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleLarge,
                      ),
                    ),
                    if (widget.infoWidget != null) widget.infoWidget!,
                  ],
                ),
              ),
              RowGap(
                gap: AppSizes.kSmallGap,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloorOutlinedButton(
                    iconData: widget.iconData,
                    text: widget.iconText,
                    loading: _isLoading || _isAttaching,
                    onPressed: widget.disablePickFile ? null : () => onPickFilesButtonPress(widget.onPickFiles),
                  ),
                  if (widget.iconData2 != null && widget.onPickFiles2 != null)
                    FloorOutlinedButton(
                      iconData: widget.iconData2,
                      loading: _isLoading || _isAttaching,
                      onPressed: widget.disablePickFile ? null : () => onPickFilesButtonPress(widget.onPickFiles2!),
                    ),
                ],
              ),
            ],
          ),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_previewImages.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RowGap(
                crossAxisAlignment: CrossAxisAlignment.center,
                gap: AppSizes.kSmallGap,
                children: _previewImages.mapIndexed((index, _) => buildFilePreview(index)).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
