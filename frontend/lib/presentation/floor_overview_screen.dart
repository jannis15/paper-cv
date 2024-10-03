import 'package:floor_cv/components/floor_app_bar.dart';
import 'package:floor_cv/components/floor_attachment_card.dart';
import 'package:floor_cv/components/floor_buttons.dart';
import 'package:floor_cv/components/floor_card.dart';
import 'package:floor_cv/components/floor_file_picker.dart';
import 'package:floor_cv/components/floor_loader_overlay.dart';
import 'package:floor_cv/components/floor_text_field.dart';
import 'package:floor_cv/config/config.dart';
import 'package:floor_cv/data/models/floor_dto_models.dart';
import 'package:floor_cv/data/models/floor_enums.dart';
import 'package:floor_cv/data/repositories/floor_repository.dart';
import 'package:floor_cv/domain/floor_models.dart';
import 'package:floor_cv/utils/file_picker_models.dart';
import 'package:floor_cv/utils/list_utils.dart';
import 'package:floor_cv/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

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
  final List<SelectedFile> _initialCaptures = [];
  final List<SelectedFile> _initialScans = [];

  @override
  void initState() {
    _isLoading = widget.documentId != null;
    if (_isLoading) {
      _asyncInit();
    } else {
      _form = DocumentForm(
        captures: [],
        scans: [],
      );
    }
    super.initState();
  }

  void _asyncInit() async {
    try {
      _form = await FloorRepository.getDocumentFormById(widget.documentId!);
      _initialCaptures.addAll(_form.captures.map((e) => e.toSelectedFile()));
      _initialScans.addAll(_form.scans.map((e) => e.toSelectedFile()));
    } finally {
      _isLoading = false;
      if (mounted) setState(() {});
    }
  }

  Future<void> _saveForm() async {
    _isSaving = true;
    if (mounted) setState(() {});
    try {
      await FloorRepository.saveDocumentForm(_form);
    } finally {
      _isSaving = false;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildScanCard() => FloorAttachmentCard(
          title: 'Scan',
          initialFiles: _initialScans,
          iconData: Icons.cloud_upload,
          iconText: 'Hochladen',
          onPickFiles: () async {
            final ScanPropertiesDto scanProperties = await FloorRepository.scanCapture(_form.captures.first);
            final newFile = scanProperties.toFileDto(formId: _form.uuid);
            _form.scans.add(newFile);
            if (mounted) setState(() {});
            final newSelectedFile = newFile.toSelectedFile();
            return [newSelectedFile];
          },
          onRemoveFile: (_, __) => null,
        );

    Widget buildTemplateCard() => FloorAttachmentCard(
          title: 'Vorlage',
          iconData: Icons.calculate,
          iconText: 'Auswählen',
          onPickFiles: () async => null,
          onRemoveFile: (_, __) => null,
        );

    Widget buildReportCard() => FloorAttachmentCard(
          title: 'Bericht',
          iconData: Icons.auto_awesome,
          iconText: 'Generieren',
          onPickFiles: () async => null,
          onRemoveFile: (_, __) => null,
        );

    return Scaffold(
      appBar: FloorAppBar(
        customPop: () async {
          await _saveForm();
          if (mounted) Navigator.of(context).pop();
        },
      ),
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
                                    },
                                    decoration: outlinedInputDecoration(labelText: 'Titel'),
                                  ),
                                  FloorTextField(
                                    text: _form.notes,
                                    onChanged: (value) {
                                      _form.notes = value;
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
                    FloorAttachmentCard(
                      title: 'Aufnahme',
                      initialFiles: _initialCaptures,
                      iconData: Icons.add_a_photo,
                      onPickFiles: () async {
                        final file = await FloorFilePicker.pickFile(context, pickerOption: FilePickerOption.camera);
                        if (file != null) {
                          final now = DateTime.now();
                          final fileDto = FileDto(
                            uuid: null,
                            refUuid: null,
                            filename: file.name,
                            data: file.bytes,
                            index: null,
                            fileType: FileType.capture,
                            createdAt: now,
                            modifiedAt: now,
                          );
                          _form.captures.add(fileDto);
                          if (mounted) setState(() {});
                        }
                        return [file].whereType<SelectedFile>().toList();
                      },
                      onRemoveFile: (fileIndex, file) {
                        _form.captures.removeAt(fileIndex);
                        if (mounted) setState(() {});
                      },
                    ),
                    if (_form.captures.isNotEmpty)
                      buildScanCard()
                    else
                      IntrinsicHeight(
                        child: FloorLoaderOverlay(
                          loading: true,
                          disableBackButton: false,
                          loadingWidget: const SizedBox(),
                          child: buildScanCard(),
                        ),
                      ),
                    // if (_form.scans.isNotEmpty)
                    //   buildTemplateCard()
                    // else
                    //   IntrinsicHeight(
                    //     child: FloorLoaderOverlay(
                    //       loading: true,
                    //       disableBackButton: false,
                    //       loadingWidget: const SizedBox(),
                    //       child: buildTemplateCard(),
                    //     ),
                    //   ),
                    if (_form.scans.isNotEmpty)
                      buildReportCard()
                    else
                      IntrinsicHeight(
                        child: FloorLoaderOverlay(
                          loading: true,
                          disableBackButton: false,
                          loadingWidget: const SizedBox(),
                          child: buildReportCard(),
                        ),
                      ),
                    // IntrinsicHeight(
                    //   child: FloorLoaderOverlay(
                    //     loading: true,
                    //     disableBackButton: false,
                    //     loadingWidget: const SizedBox(),
                    //     child: FloorFilledButton(
                    //       iconData: Icons.lock,
                    //       text: 'Abschließen',
                    //       onPressed: () {},
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
}
