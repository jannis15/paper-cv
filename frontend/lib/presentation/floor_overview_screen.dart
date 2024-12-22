import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_attachment_card.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/components/floor_date_picker.dart';
import 'package:paper_cv/components/floor_date_picker_dialog.dart';
import 'package:paper_cv/components/floor_file_picker.dart';
import 'package:paper_cv/components/floor_icon_button.dart';
import 'package:paper_cv/components/floor_layout_body.dart';
import 'package:paper_cv/components/floor_loader_overlay.dart';
import 'package:paper_cv/components/floor_text_field.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/data/repositories/floor_repository.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/presentation/floor_table_selection_screen.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:paper_cv/utils/file_picker_utils.dart';
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
  final CancelToken _cancelToken = CancelToken();
  late bool _isLoading;
  bool _isSaving = false;
  late DocumentForm _form;
  bool _isDirty = false; // if true, the form needs to be saved
  bool _showDocumentDetails = false;

  void _setIsDirty() {
    _isDirty = true;
  }

  @override
  void initState() {
    _isLoading = widget.documentId != null;
    if (_isLoading) {
      _asyncInit();
    } else {
      final now = DateTime.now();
      _form = DocumentForm(documentDate: now);
    }
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel('Hochladen wurde abgebrochen');
    super.dispose();
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
      _form.title = _form.title.trim();
      _form.notes = _form.notes.trim();
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
          iconData2: Icons.perm_media,
          onPickFiles: () async {
            final file = await FloorFilePicker.pickFile(context, pickerOption: FilePickerOption.camera);
            if (file == null) return null;
            final now = DateTime.now();
            final String formattedDate = DateFormat('dd.MM.yy HH:mm').format(now);
            file.filename = 'Aufnahme $formattedDate.jpg';
            file.fileType = FileType.capture;
            return [file];
          },
          onPickFiles2: () async {
            final files = await FilePickerHelper.pickImageSelectedFile(context, allowMultiple: true);
            for (final file in files) {
              final now = DateTime.now();
              final String formattedDate = DateFormat('dd.MM.yy HH:mm').format(now);
              file.filename = 'Aufnahme $formattedDate.jpg';
              file.fileType = FileType.capture;
            }
            return files;
          },
          onAddFiles: (_) => setState(() {
            _setIsDirty();
          }),
          onRemoveFile: (file) => setState(() {
            _form.selections.remove(file);
            _setIsDirty();
          }),
          onTapFile: (file, image) async {
            if (image != null) {
              final selectionResult = await Navigator.of(context).push<bool?>(
                MaterialPageRoute(
                  builder: (context) => FloorTableSelectionScreen(
                    file: file,
                    image: image,
                    document: _form,
                  ),
                ),
              );
              if (mounted && selectionResult == true)
                setState(() {
                  _isDirty = true;
                });
            }
          },
          fileStatusWidget: (file) => FloorIconButton(
            iconData: _form.selections[file]?.isSet == true ? Icons.check : Icons.document_scanner,
            foregroundColor: _form.selections[file]?.isSet == true ? Colors.white : Colors.black,
            backgroundColor: _form.selections[file]?.isSet == true ? Colors.green : Colors.amber,
            onPressed: () {},
          ),
        );

    Widget buildScanCard() => FloorAttachmentCard(
          title: 'Scan',
          files: _form.scans,
          iconData: Icons.cloud_upload,
          iconText: 'Hochladen',
          onPickFiles: () async {
            final result = <SelectedFile>[];
            for (final capture in _form.captures) {
              final scanProperties = await FloorRepository.scanCapture(capture, _form.selections[capture]!.toTDto(), cancelToken: _cancelToken);
              final newSelectedFile = scanProperties.toSelectedFile();
              result.add(newSelectedFile);
            }
            return result;
          },
          onAddFiles: (_) => setState(() {
            _setIsDirty();
          }),
          onRemoveFile: (_) => setState(() {
            _setIsDirty();
          }),
          disablePickFile: _form.captures.isEmpty || !_form.selectionsReady,
          infoWidget: _form.captures.isNotEmpty && _form.scans.isEmpty
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.kSmallGap),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(side: BorderSide(color: _form.selectionsReady ? Colors.green : Colors.amber)),
                  ),
                  child: Text(
                    _form.selectionsReady ? 'Bereit' : 'Selektion erforderlich',
                    style: textTheme.titleMedium?.copyWith(color: _form.selectionsReady ? Colors.green : Colors.amber),
                  ),
                )
              : null,
        );

    Widget buildReportCard() => FloorAttachmentCard(
          title: 'Bericht',
          files: _form.reports,
          iconData: Icons.auto_awesome,
          iconText: 'Generieren',
          onPickFiles: () async {
            final List<ScanPropertiesDto> scanPropertiesList = [];
            for (final scan in _form.scans) {
              final scanProperties = ScanPropertiesDto.fromJson(jsonDecode(utf8.decode(scan.data)));
              scanPropertiesList.add(scanProperties);
            }
            final pdfData = await FloorRepository.createPdf(scanPropertiesList);
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
        backgroundColor: useDesktopLayout ? colorScheme.surfaceContainer : null,
        appBar: FloorAppBar(
          title: useDesktopLayout ? Text('Dokument') : null,
          showBackButton: !useDesktopLayout,
          customPop: tryCloseForm,
        ),
        body: FloorLoaderOverlay(
          loading: _isSaving,
          child: FloorLayoutBody(
            sideChildren: [
              FloorTransparentButton(
                text: 'Zurück',
                iconData: Icons.chevron_left,
                onPressed: tryCloseForm,
              ),
            ],
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: EdgeInsets.all(AppSizes.kGap),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: AppSizes.kDesktopWidth,
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Bemerkung', style: textTheme.titleLarge),
                                          FloorIconButton(
                                            iconData: _showDocumentDetails ? Icons.expand_less : Icons.expand_more,
                                            onPressed: () {
                                              _showDocumentDetails = !_showDocumentDetails;
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                      if (_showDocumentDetails) SizedBox(height: AppSizes.kGap),
                                      AnimatedSize(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn,
                                        child: _showDocumentDetails
                                            ? ColumnGap(
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
                                                  FloorDatePicker(
                                                    labelText: 'Dokumentdatum',
                                                    value: _form.documentDate,
                                                    onSetValue: (dateTime) {
                                                      _form.documentDate = dateTime;
                                                      _setIsDirty();
                                                      setState(() {});
                                                    },
                                                    overlayPicker: FloorDatePickerDialog(selectedDay: _form.documentDate),
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
                                              )
                                            : SizedBox(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            buildCaptureCard(),
                            if (_form.captures.isNotEmpty || _form.scans.isNotEmpty) buildScanCard() else buildDisabledChild(child: buildScanCard()),
                            if (_form.scans.isNotEmpty || _form.reports.isNotEmpty)
                              buildReportCard()
                            else
                              buildDisabledChild(child: buildReportCard()),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
