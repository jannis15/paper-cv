import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paper_cv/core/components/floor_buttons.dart';
import 'package:paper_cv/core/components/floor_card.dart';
import 'package:paper_cv/core/components/floor_layout_body.dart';
import 'package:paper_cv/core/components/floor_loader_overlay.dart';
import 'package:paper_cv/core/components/floor_text_field.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/features/document/domain/models/floor_models.dart';
import 'package:paper_cv/features/document/data/repositories/floor_repository_impl.dart';
import 'package:paper_cv/core/utils/file_picker_models.dart';
import 'package:paper_cv/core/utils/list_utils.dart';
import 'package:paper_cv/core/utils/widget_utils.dart';

import '../../../../core/components/floor_scroll.dart';
import 'package:paper_cv/generated/l10n.dart';

import '../../../../config/settings.dart';
import '../../../../config/settings_notifier.dart';

class FloorEditTableScreen extends ConsumerStatefulWidget {
  final SelectedFile file;
  final DocumentForm form;

  FloorEditTableScreen({
    Key? key,
    required this.file,
    required this.form,
  })  : assert(file.fileType == FileType.scan, 'File type is not a scan!'),
        super(key: key);

  @override
  _FloorEditTableScreenState createState() => _FloorEditTableScreenState();
}

class _FloorEditTableScreenState extends ConsumerState<FloorEditTableScreen> {
  bool _showImage = true;
  bool _isRecalculating = false;
  late final SelectedFile? _capture;
  late List<List<TextEditingController?>> _controllers;
  late final ScanForm _form;
  late final List<List<bool>> _editableMap;

  void _setEditableForColumns(List<List<bool>> editableMap, List<int> columns) {
    for (int col in columns) {
      for (int row = 1; row < editableMap[col].length; row++) {
        editableMap[col][row] = true;
      }
    }
  }

  void _initScanForm() {
    final scanResult = ScanResultDto.fromJson(jsonDecode(utf8.decode(widget.file.data)));
    _form = scanResult.toForm();
  }

  void _initTable() {
    _editableMap = List.generate(_form.cellTexts.length, (_) => List.generate(_form.cellTexts[0].length, (_) => false));
    if (_editableMap.isNotEmpty) {
      // always set editable for first row
      for (int i = 0; i < _editableMap.length; i++) {
        _editableMap[i][0] = true;
      }
    }
    _setEditableForColumns(_editableMap, [0, 1, 3, 5, 7]);
    _controllers = _form.cellTexts.map((row) => row.map((cell) => TextEditingController(text: cell)).toList()).toList();
  }

  void _initImage() {
    final captures = widget.form.captures.where((capture) => capture.uuid == _form.refUuid);
    if (captures.isNotEmpty) {
      _capture = captures.firstOrNull;
    } else {
      _capture = null;
    }
  }

  void _doRecalculation() async {
    _isRecalculating = true;
    setState(() {});
    try {
      final ScanRecalculationDto response = await FloorRepository.recalculateScan(
        ScanRecalculationDto(
          cellTexts: _form.cellTexts,
          templateNo: 1,
        ),
      );
      _form.cellTexts.clear();
      _form.cellTexts.addAll(response.cellTexts);
      _resyncTextControllers();
    } finally {
      _isRecalculating = false;
      if (mounted) setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _initScanForm();
    _initTable();
    _initImage();
  }

  @override
  void dispose() {
    for (final List<TextEditingController?> row in _controllers) {
      for (final TextEditingController? controller in row) {
        controller?.dispose();
      }
    }
    super.dispose();
  }

  void _saveChanges(Settings settings) async {
    final newSelectedFile = _form.toDto().toSelectedFile(settings.locale);
    Navigator.of(context).pop(newSelectedFile);
  }

  void _resyncTextControllers() {
    _controllers.mapIndexed(
      (col, list) => list.mapIndexed(
        (row, controller) {
          if (controller != null) {
            controller.text = _form.cellTexts[col][row];
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsNotifierProvider);
    Widget buildScrollTable() => FloorScroll(
          child: Column(
            children: [
              Table(
                columnWidths: {
                  for (int i = 0; i < _form.columnWidthsCm.length; i++) i: FixedColumnWidth(_form.columnWidthsCm[i] * 50),
                },
                children: _form.cellTexts[0]
                    .mapIndexed(
                      (rowIdx, _) => TableRow(
                        children: _form.cellTexts.mapIndexed((colIdx, _) {
                          final bool isTextEmpty = _controllers[colIdx][rowIdx]?.value.text.isEmpty ?? false;
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppSizes.kSmallGap),
                            child: _editableMap[colIdx][rowIdx]
                                ? FloorTextField(
                                    controller: _controllers[colIdx][rowIdx],
                                    decoration: InputDecoration(
                                        hintText: isTextEmpty ? '[...]' : null,
                                        hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.outline.withOpacity(.5)),
                                        border: InputBorder.none),
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: rowIdx == 0 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    onChanged: (value) {
                                      _form.cellTexts[colIdx][rowIdx] = value;
                                    },
                                  )
                                : Text(
                                    _form.cellTexts[colIdx][rowIdx],
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Color.alphaBlend(
                                        colorScheme.onSurface.withOpacity(.5),
                                        colorScheme.surface,
                                      ),
                                      fontWeight: rowIdx == 0 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                          );
                        }).toList(),
                      ),
                    )
                    .toList(),
              ),
              if (!_isRecalculating && !useDesktopLayout) SizedBox(height: 64 + 10),
            ],
          ),
        );

    Widget buildConfirmButton(Settings settings) => FloorButton(
          type: FloorButtonType.filled,
          iconData: Icons.check,
          text: S.current.confirm,
          onPressed: () => _saveChanges(settings),
        );

    Widget buildShowImageButton() => FloorOutlinedButton(
          iconData: _showImage ? Icons.visibility : Icons.visibility_off,
          text: S.current.image,
          onPressed: () {
            setState(() {
              _showImage = !_showImage;
            });
          },
        );

    Widget buildRecalculateButton() => FloorOutlinedButton(
          text: S.current.recalculate,
          onPressed: _doRecalculation,
        );

    return FloorLoaderOverlay(
      loading: _isRecalculating,
      child: FloorLayoutBody(
        title: Text(S.current.scan),
        actions: useDesktopLayout
            ? null
            : [
                buildShowImageButton(),
                buildConfirmButton(settings),
              ],
        floatingActionButton: !useDesktopLayout && !_isRecalculating
            ? FloatingActionButton.extended(
                onPressed: _doRecalculation,
                label: Text(S.current.recalculate),
              )
            : null,
        sideChildren: useDesktopLayout
            ? [
                FloorTransparentButton(
                  text: S.current.back,
                  iconData: Icons.chevron_left,
                  onPressed: Navigator.of(context).pop,
                ),
                Divider(),
                if (_capture != null) ...[
                  buildShowImageButton(),
                  Divider(),
                ],
                buildRecalculateButton(),
                buildConfirmButton(settings),
              ]
            : [],
        child: _showImage && _capture != null
            ? Padding(
                padding: EdgeInsets.all(AppSizes.kSmallGap),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return FlexGap(
                      separator: useDesktopLayout ? SizedBox(width: AppSizes.kSmallGap) : SizedBox(height: AppSizes.kSmallGap),
                      direction: useDesktopLayout ? Axis.horizontal : Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: useDesktopLayout ? null : constraints.maxHeight * 0.4,
                          width: useDesktopLayout ? constraints.maxWidth * 0.4 : null,
                          child: FloorCard(
                            usePadding: false,
                            child: InteractiveViewer(
                              maxScale: 4,
                              minScale: 1,
                              child: Image.memory(_capture.data, fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        Expanded(child: FloorCard(usePadding: false, child: buildScrollTable())),
                      ],
                    );
                  },
                ),
              )
            : buildScrollTable(),
      ),
    );
  }
}
