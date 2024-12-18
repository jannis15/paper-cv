import 'dart:ui' as ui show Image;
import 'package:collection/collection.dart';
import 'package:file_icon/file_icon.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/components/floor_icon_button.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/alert_dialog.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/ui_image_extension.dart';
import 'package:paper_cv/utils/widget_utils.dart';
import "package:flutter/material.dart";
import 'package:mime/mime.dart';
import 'package:paper_cv/utils/mobile_access_file.dart' if (dart.library.html) 'package:paper_cv/utils/web_access_file.dart';

class FloorAttachmentCard extends StatefulWidget {
  final String title;
  final List<SelectedFile> files;
  final Future<List<SelectedFile>?> Function() onPickFiles;
  final Future<List<SelectedFile>?> Function()? onPickFiles2;
  final Function(List<SelectedFile> files) onAddFiles;
  final Function(SelectedFile file) onRemoveFile;
  final IconData iconData;
  final IconData? iconData2;
  final String iconText;
  final bool disablePickFile;

  const FloorAttachmentCard({
    super.key,
    required this.title,
    required this.files,
    required this.onPickFiles,
    this.onPickFiles2,
    required this.onAddFiles,
    required this.onRemoveFile,
    this.disablePickFile = false,
    this.iconData = Icons.add,
    this.iconData2,
    this.iconText = 'Hinzufügen',
  }) : assert((iconData2 == null && onPickFiles2 == null) || (iconData2 != null && onPickFiles2 != null), 'FloorAttachmentCard wrong parameters!');

  @override
  State<FloorAttachmentCard> createState() => _FloorAttachmentCardState();
}

class _FloorAttachmentCardState extends State<FloorAttachmentCard> {
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
      if (lookupMimeType('', headerBytes: file.data)?.contains('image') ?? false) {
        tmpImage = await decodeImageFromList(file.data);
      }
      _previewImages.add(tmpImage);
    }
  }

  Future<void> _onPickFilesButtonPress(Future<List<SelectedFile>?> Function() onPickFiles) async {
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
    const double kRatio = 5 / 7;
    const double kAntiRatio = 1 / kRatio;
    const double kMaxHeight = 100.0;
    Widget buildFilePreview(int index) {
      final ui.Image? previewImage = _previewImages[index];
      final SelectedFile file = _files[index];
      return Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              accessFile(file);
            },
            child: Container(
              margin: EdgeInsets.only(
                top: AppSizes.kIconButtonSize / 2,
                right: AppSizes.kIconButtonSize / 2,
              ),
              width: previewImage != null
                  ? previewImage.isLandscape
                      ? kMaxHeight * kAntiRatio
                      : kMaxHeight * kRatio
                  : kMaxHeight,
              height: kMaxHeight,
              decoration: BoxDecoration(color: colorScheme.surface),
              child: previewImage != null
                  ? FittedBox(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      child: RawImage(image: previewImage),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(AppSizes.kSmallGap),
                      child: ColumnGap(
                        mainAxisAlignment: MainAxisAlignment.center,
                        gap: 4,
                        children: [
                          FileIcon(file.filename, size: 32),
                          Text(
                            file.filename,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: FloorIconButton(
              iconData: Icons.close,
              foregroundColor: colorScheme.onPrimary,
              backgroundColor: colorScheme.primary,
              onPressed: () async {
                final alertResult = await showAlertDialog(
                  context,
                  title: "'${file.filename}' entfernen?",
                  optionData: [
                    AlertOptionData.cancel(),
                    AlertOptionData.yes(customText: 'Entfernen'),
                  ],
                );
                if (alertResult == AlertOption.yes) {
                  _files.removeAt(index);
                  _previewImages.removeAt(index);
                  await widget.onRemoveFile(file);
                  if (context.mounted) setState(() {});
                }
              },
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
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleLarge,
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
                    onPressed: widget.disablePickFile ? null : () => _onPickFilesButtonPress(widget.onPickFiles),
                  ),
                  if (widget.iconData2 != null && widget.onPickFiles2 != null)
                    FloorOutlinedButton(
                      iconData: widget.iconData2,
                      loading: _isLoading || _isAttaching,
                      onPressed: widget.disablePickFile ? null : () => _onPickFilesButtonPress(widget.onPickFiles2!),
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
