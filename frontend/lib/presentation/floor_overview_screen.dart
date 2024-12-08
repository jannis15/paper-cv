import 'package:intl/intl.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_attachment_card.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/components/floor_file_picker.dart';
import 'package:paper_cv/components/floor_loader_overlay.dart';
import 'package:paper_cv/components/floor_text_field.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/data/repositories/floor_repository.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import 'dart:convert';

class FloorOverviewScreen extends StatefulWidget {
  final String? documentId;

  const FloorOverviewScreen({
    super.key,
    this.documentId,
  });

  @override
  State<FloorOverviewScreen> createState() => _FloorOverviewScreenState();
}

class _FloorOverviewScreenState extends State<FloorOverviewScreen> {
  late bool _isLoading;
  bool _isSaving = false;
  late DocumentForm _form;
  bool _isDirty = false; // if true, the form needs to be saved

  void _setIsDirty() {
    _isDirty = true;
  }

  @override
  void initState() {
    _isLoading = widget.documentId != null;
    if (_isLoading) {
      _asyncInit();
    } else {
      _form = DocumentForm();
    }
    super.initState();
  }

  void _asyncInit() async {
    try {
      _form = await FloorRepository.getDocumentFormById(widget.documentId!);
    } finally {
      _isLoading = false;
      if (mounted) setState(() {});
    }
  }

  Future<bool> _saveForm() async {
    _isSaving = true;
    if (mounted) setState(() {});
    try {
      await FloorRepository.saveDocumentForm(_form);
    } finally {
      _isSaving = false;
      if (mounted) setState(() {});
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Widget buildDisabledChild({required Widget child}) => IntrinsicHeight(
          child: FloorLoaderOverlay(
            loading: true,
            disableBackButton: false,
            loadingWidget: const SizedBox(),
            child: child,
          ),
        );

    Widget buildCaptureCard() => FloorAttachmentCard(
          title: 'Aufnahme',
          files: _form.captures,
          iconData: Icons.add_a_photo,
          onPickFiles: () async {
            final file = await FloorFilePicker.pickFile(context, pickerOption: FilePickerOption.camera);
            if (file == null) return null;
            final now = DateTime.now();
            final String formattedDate = DateFormat('dd.MM.yy HH:mm').format(now);
            file.filename = 'Aufnahme $formattedDate.jpg';
            file.fileType = FileType.capture;
            return [file];
          },
          onAddFiles: (_) => setState(() {
            _setIsDirty();
          }),
          onRemoveFile: (_) => setState(() {
            _setIsDirty();
          }),
        );

    Widget buildScanCard() => FloorAttachmentCard(
          title: 'Scan',
          files: _form.scans,
          iconData: Icons.cloud_upload,
          iconText: 'Hochladen',
          onPickFiles: () async {
            final scanProperties = await FloorRepository.scanCapture(_form.captures.first);
            final newSelectedFile = scanProperties.toSelectedFile();
            return [newSelectedFile];
          },
          onAddFiles: (_) => setState(() {
            _setIsDirty();
          }),
          onRemoveFile: (_) => setState(() {
            _setIsDirty();
          }),
          disablePickFile: _form.captures.isEmpty,
        );

    Widget buildReportCard() => FloorAttachmentCard(
          title: 'Bericht',
          files: _form.reports,
          iconData: Icons.auto_awesome,
          iconText: 'Generieren',
          onPickFiles: () async {
            final scanProperties = ScanPropertiesDto.fromJson(jsonDecode(utf8.decode(_form.scans.first.data)));
            final pdfData = await FloorRepository.createPdf(scanProperties);
            final now = DateTime.now();
            final String formattedDate = DateFormat('dd.MM.yy HH:mm').format(now);
            final selectedFile = SelectedFile(
              filename: 'Bericht $formattedDate.pdf',
              data: pdfData,
              fileType: FileType.report,
              createdAt: now,
              modifiedAt: now,
            );
            return [selectedFile];
          },
          onAddFiles: (_) => setState(() {
            _setIsDirty();
          }),
          onRemoveFile: (_) => setState(() {
            _setIsDirty();
          }),
          disablePickFile: _form.scans.isEmpty,
        );

    Future<void> tryCloseForm() async {
      if (_isDirty) {
        if (!(await _saveForm())) return;
      }
      if (mounted) Navigator.of(context).pop();
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await tryCloseForm();
        }
      },
      child: Scaffold(
        appBar: FloorAppBar(customPop: tryCloseForm),
        body: FloorLoaderOverlay(
          loading: _isSaving,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: EdgeInsets.all(AppSizes.kGap),
                  child: ColumnGap(
                    gap: AppSizes.kGap,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ColumnGap(
                        gap: AppSizes.kSmallGap,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (_form.modifiedAt != null)
                            RowGap(
                              gap: 4,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: colorScheme.outline,
                                  size: AppSizes.kSubIconSize,
                                ),
                                Timeago(
                                  locale: 'de',
                                  date: _form.modifiedAt!,
                                  builder: (context, value) => Text(
                                    value,
                                    style: textTheme.labelMedium?.copyWith(color: colorScheme.outline),
                                  ),
                                ),
                              ],
                            ),
                          FloorCard(
                            child: ColumnGap(
                              gap: AppSizes.kGap,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Kopfdaten', style: textTheme.titleLarge),
                                ColumnGap(
                                  gap: AppSizes.kSmallGap,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    FloorTextField(
                                      text: _form.title,
                                      onChanged: (value) {
                                        _form.title = value;
                                        _setIsDirty();
                                      },
                                      decoration: outlinedInputDecoration(labelText: 'Titel'),
                                    ),
                                    FloorTextField(
                                      text: _form.notes,
                                      onChanged: (value) {
                                        _form.notes = value;
                                        _setIsDirty();
                                      },
                                      decoration: outlinedInputDecoration(labelText: 'Notizen'),
                                      minLines: 4,
                                      maxLines: null,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      buildCaptureCard(),
                      if (_form.captures.isNotEmpty || _form.scans.isNotEmpty) buildScanCard() else buildDisabledChild(child: buildScanCard()),
                      if (_form.scans.isNotEmpty || _form.reports.isNotEmpty) buildReportCard() else buildDisabledChild(child: buildReportCard()),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
