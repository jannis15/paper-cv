import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_layout_body.dart';
import 'package:paper_cv/components/floor_text_field.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:paper_cv/utils/widget_utils.dart';

class FloorEditTableScreen extends StatefulWidget {
  final SelectedFile file;

  FloorEditTableScreen({
    Key? key,
    required this.file,
  })  : assert(file.fileType == FileType.scan, 'File type is not a scan!'),
        super(key: key);

  @override
  _FloorEditTableScreenState createState() => _FloorEditTableScreenState();
}

class _FloorEditTableScreenState extends State<FloorEditTableScreen> {
  final ScrollController _horzController = ScrollController();
  final ScrollController _vertController = ScrollController();
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

  @override
  void initState() {
    super.initState();
    final scanResult = ScanResultDto.fromJson(jsonDecode(utf8.decode(widget.file.data)));
    _form = scanResult.toForm();

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

  @override
  void dispose() {
    for (final List<TextEditingController?> row in _controllers) {
      for (final TextEditingController? controller in row) {
        controller?.dispose();
      }
    }
    super.dispose();
  }

  void _saveChanges() async {
    final newSelectedFile = _form.toDto().toSelectedFile();
    Navigator.of(context).pop(newSelectedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FloorAppBar(
        backgroundColor: colorScheme.surface,
        actions: [
          FloorButton(
            type: FloorButtonType.outlined,
            iconData: Icons.check,
            text: 'Bestätigen',
            onPressed: _saveChanges,
          )
        ],
      ),
      body: FloorLayoutBody(
        child: SizedBox(
          height: 500,
          width: 400,
          child: Scrollbar(
            controller: _vertController,
            thumbVisibility: true,
            child: Scrollbar(
              controller: _horzController,
              thumbVisibility: true,
              notificationPredicate: (notif) => notif.depth == 1,
              child: SingleChildScrollView(
                controller: _vertController,
                child: SingleChildScrollView(
                  controller: _horzController,
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    columnWidths: {
                      for (int i = 0; i < _form.columnWidthsCm.length; i++) i: FixedColumnWidth(_form.columnWidthsCm[i] * 100),
                    },
                    children: _form.cellTexts[0]
                        .mapIndexed(
                          (rowIdx, _) => TableRow(
                            children: _form.cellTexts.mapIndexed((colIdx, _) {
                              final bool isTextEmpty = _controllers[colIdx][rowIdx]?.value.text.isEmpty ?? false;
                              return Padding(
                                padding: EdgeInsets.all(AppSizes.kSmallGap),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
