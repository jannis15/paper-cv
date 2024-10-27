import 'dart:io';
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
import 'package:paper_cv/utils/widget_utils.dart';
import "package:flutter/material.dart";
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class _SelectedFilePreview extends SelectedFile {
  ui.Image? image;

  bool get isLandscape => image != null ? image!.width > image!.height : false;

  bool get isImage => image != null;

  _SelectedFilePreview({
    this.image,
    super.id,
    required super.name,
    required super.bytes,
  });
}

class FloorAttachmentCard extends StatefulWidget {
  final String title;
  final List<SelectedFile>? initialFiles;
  final Future<List<SelectedFile>?> Function() onPickFiles;
  final Function(int fileIndex, SelectedFile file) onRemoveFile;
  final IconData iconData;
  final String iconText;

  const FloorAttachmentCard({
    super.key,
    required this.title,
    this.initialFiles,
    required this.onPickFiles,
    required this.onRemoveFile,
    this.iconData = Icons.add,
    this.iconText = 'Hinzufügen',
  });

  @override
  State<FloorAttachmentCard> createState() => _FloorAttachmentCardState();
}

class _FloorAttachmentCardState extends State<FloorAttachmentCard> {
  final List<_SelectedFilePreview> _filePreviews = [];
  bool _isLoading = true;
  bool _isAttaching = false;

  @override
  void initState() {
    super.initState();
    _asyncInit();
  }

  void _asyncInit() async {
    if (widget.initialFiles != null) {
      await _addFilePreviews(widget.initialFiles!);
    }
    _isLoading = false;
    if (mounted) setState(() {});
  }

  Future<void> _addFilePreviews(List<SelectedFile> files) async {
    for (final file in files) {
      ui.Image? tmpImage;
      if (lookupMimeType('', headerBytes: file.bytes)?.contains('image') ?? false) {
        tmpImage = await decodeImageFromList(file.bytes);
      }
      final newPreview = _SelectedFilePreview(
        image: tmpImage,
        id: file.id,
        name: file.name,
        bytes: file.bytes,
      );
      _filePreviews.add(newPreview);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double kRatio = 5 / 7;
    const double kAntiRatio = 1 / kRatio;
    const double kMaxHeight = 100.0;
    Widget buildFilePreview(int index, _SelectedFilePreview preview) {
      return Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              final directory = await getTemporaryDirectory();
              final path = '${directory.path}/${preview.name}';
              final file = File(path);
              await file.writeAsBytes(preview.bytes);
              await OpenFile.open(path);
            },
            child: Container(
              margin: EdgeInsets.only(top: AppSizes.kIconButtonSize / 2, right: AppSizes.kIconButtonSize / 2),
              width: preview.isImage
                  ? preview.isLandscape
                      ? kMaxHeight * kAntiRatio
                      : kMaxHeight * kRatio
                  : kMaxHeight,
              height: kMaxHeight,
              decoration: BoxDecoration(color: colorScheme.surface),
              child: preview.isImage
                  ? Image.memory(preview.bytes, fit: BoxFit.cover, alignment: Alignment.center)
                  : Padding(
                      padding: const EdgeInsets.all(AppSizes.kSmallGap),
                      child: ColumnGap(
                        mainAxisAlignment: MainAxisAlignment.center,
                        gap: 4,
                        children: [
                          FileIcon(preview.name, size: 32),
                          Text(preview.name, textAlign: TextAlign.center, maxLines: 2, style: textTheme.labelSmall),
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
                  title: "'${preview.name}' entfernen?",
                  optionData: [
                    AlertOptionData.cancel(),
                    AlertOptionData.yes(),
                  ],
                );
                if (alertResult == AlertOption.yes) {
                  await widget.onRemoveFile(index, preview);
                  _filePreviews.removeAt(index);
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
              FloorOutlinedButton(
                iconData: widget.iconData,
                text: widget.iconText,
                loading: _isLoading || _isAttaching,
                onPressed: () async {
                  _isAttaching = true;
                  setState(() {});
                  try {
                    final newFiles = await widget.onPickFiles();
                    if (newFiles != null && newFiles.isNotEmpty) {
                      await _addFilePreviews(newFiles);
                    }
                  } finally {
                    _isAttaching = false;
                    if (context.mounted) setState(() {});
                  }
                },
              ),
            ],
          ),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_filePreviews.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RowGap(
                crossAxisAlignment: CrossAxisAlignment.center,
                gap: AppSizes.kSmallGap,
                children: _filePreviews.mapIndexed(buildFilePreview).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
