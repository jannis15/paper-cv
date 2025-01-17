import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_layout_body.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/selection_extension.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/math_utils.dart';
import 'package:paper_cv/utils/rect_extension.dart';
import 'package:paper_cv/utils/widget_utils.dart';
import 'package:paper_cv/generated/l10n.dart';

class FloorTableSelectionScreen extends StatefulWidget {
  final SelectedFile file;
  final ui.Image image;
  final DocumentForm document;

  const FloorTableSelectionScreen({
    required this.file,
    required this.image,
    required this.document,
  });

  @override
  _FloorTableSelectionScreenState createState() => _FloorTableSelectionScreenState();
}

class _SelectionPaint {
  Offset? startDrag;
  Offset? endDrag;
  final Color color;

  _SelectionPaint(
    this.startDrag,
    this.endDrag,
    this.color,
  );

  bool get isSet => startDrag != null && endDrag != null;

  bool get isEmpty => startDrag == null && endDrag == null;

  double get area => (startDrag == null || endDrag == null) ? 0 : (endDrag!.dx - startDrag!.dx).abs() * (endDrag!.dy - startDrag!.dy).abs();
}

class _FloorTableSelectionScreenState extends State<FloorTableSelectionScreen> {
  late ui.Image _image = widget.image;
  late final _SelectionPaint _headerSelection;
  late final _SelectionPaint _tableSelection;
  Rect? _oldImageRect;
  SelectionType _selectionType = SelectionType.table;
  bool _isFirstBuild = true;

  void _initSelection() {
    final selection = widget.document.selections[widget.file];

    if (selection?.isTSet ?? false) {
      Rect transformedSelectionRect = MathHelper.applyTransformToSelection(
        oldRect: Rect.fromLTRB(
          0,
          0,
          _image.width.toDouble(),
          _image.height.toDouble(),
        ),
        newRect: _oldImageRect!.translateToOrigin(),
        selectionRect: selection!.toTRect(),
      );
      transformedSelectionRect = transformedSelectionRect.translate(_oldImageRect!.left, _oldImageRect!.top);

      _tableSelection = _SelectionPaint(
        ui.Offset(transformedSelectionRect.left, transformedSelectionRect.top),
        ui.Offset(transformedSelectionRect.right, transformedSelectionRect.bottom),
        Colors.blue,
      );
    } else {
      _tableSelection = _SelectionPaint(
        null,
        null,
        Colors.blue,
      );
    }

    if (selection?.isHSet ?? false) {
      Rect transformedSelectionRect = MathHelper.applyTransformToSelection(
        oldRect: Rect.fromLTRB(
          0,
          0,
          _image.width.toDouble(),
          _image.height.toDouble(),
        ),
        newRect: _oldImageRect!.translateToOrigin(),
        selectionRect: selection!.toHRect(),
      );
      transformedSelectionRect = transformedSelectionRect.translate(_oldImageRect!.left, _oldImageRect!.top);

      _headerSelection = _SelectionPaint(
        ui.Offset(transformedSelectionRect.left, transformedSelectionRect.top),
        ui.Offset(transformedSelectionRect.right, transformedSelectionRect.bottom),
        Colors.orange,
      );
    } else {
      _headerSelection = _SelectionPaint(
        null,
        null,
        Colors.orange,
      );
    }

    if (mounted) {
      _isFirstBuild = false;
      setState(() {});
    }
  }

  _SelectionPaint get _currentSelectionPaint => _selectionType == SelectionType.header ? _headerSelection : _tableSelection;

  void _saveChanges() {
    bool newAssign = true;
    Selection? selection = widget.document.selections[widget.file];
    if (selection != null && _tableSelection.area == 0 && _headerSelection.area == 0) {
      widget.document.selections.remove(widget.file);
    } else if (_oldImageRect != null) {
      double? tX1;
      double? tX2;
      double? tY1;
      double? tY2;
      if (_tableSelection.area != 0) {
        final Rect tableSelectionRect = MathHelper.applyTransformToSelection(
          oldRect: _oldImageRect!.translateToOrigin(),
          newRect: Rect.fromLTRB(
            0,
            0,
            _image.width.toDouble(),
            _image.height.toDouble(),
          ),
          selectionRect: Rect.fromLTRB(
            _tableSelection.startDrag!.dx - _oldImageRect!.left,
            _tableSelection.startDrag!.dy - _oldImageRect!.top,
            _tableSelection.endDrag!.dx - _oldImageRect!.left,
            _tableSelection.endDrag!.dy - _oldImageRect!.top,
          ),
        );
        tX1 = tableSelectionRect.left;
        tX2 = tableSelectionRect.right;
        tY1 = tableSelectionRect.top;
        tY2 = tableSelectionRect.bottom;
      }
      double? hX1;
      double? hX2;
      double? hY1;
      double? hY2;
      if (_headerSelection.area != 0) {
        final Rect headerSelectionRect = MathHelper.applyTransformToSelection(
          oldRect: _oldImageRect!.translateToOrigin(),
          newRect: Rect.fromLTRB(
            0,
            0,
            _image.width.toDouble(),
            _image.height.toDouble(),
          ),
          selectionRect: Rect.fromLTRB(
            _headerSelection.startDrag!.dx - _oldImageRect!.left,
            _headerSelection.startDrag!.dy - _oldImageRect!.top,
            _headerSelection.endDrag!.dx - _oldImageRect!.left,
            _headerSelection.endDrag!.dy - _oldImageRect!.top,
          ),
        );
        hX1 = headerSelectionRect.left;
        hX2 = headerSelectionRect.right;
        hY1 = headerSelectionRect.top;
        hY2 = headerSelectionRect.bottom;
      }
      if (selection == null) {
        widget.document.selections[widget.file] = Selection(
          tX1: tX1,
          tX2: tX2,
          tY1: tY1,
          tY2: tY2,
          hX1: hX1,
          hX2: hX2,
          hY1: hY1,
          hY2: hY2,
        );
      } else {
        selection
          ..tX1 = tX1
          ..tY1 = tY1
          ..tX2 = tX2
          ..tY2 = tY2
          ..hX1 = hX1
          ..hY1 = hY1
          ..hX2 = hX2
          ..hY2 = hY2;
      }
    } else {
      newAssign = false;
    }
    Navigator.of(context).pop<bool>(newAssign);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildConfirmButton() => FloorButton(
          type: !_isFirstBuild && (_headerSelection.isSet && _tableSelection.isSet) ? FloorButtonType.filled : FloorButtonType.outlined,
          iconData: Icons.check,
          text: S.current.confirm,
          onPressed: _saveChanges,
        );

    Widget buildHeaderButton() => FloorButton(
          iconData: Icons.branding_watermark,
          type: _selectionType == SelectionType.header ? FloorButtonType.filled : FloorButtonType.outlined,
          foregroundColor: _selectionType == SelectionType.header ? Color(0xFF212121) : null,
          backgroundColor: _selectionType == SelectionType.header ? Colors.orange : null,
          text: S.current.header,
          onPressed: () {
            _selectionType = SelectionType.header;
            setState(() {});
          },
        );

    Widget buildTableButton() => FloorButton(
          iconData: Icons.table_rows,
          type: _selectionType == SelectionType.table ? FloorButtonType.filled : FloorButtonType.outlined,
          foregroundColor: _selectionType == SelectionType.table ? Colors.white : null,
          backgroundColor: _selectionType == SelectionType.table ? Colors.blue : null,
          text: S.current.table,
          onPressed: () {
            _selectionType = SelectionType.table;
            setState(() {});
          },
        );

    return FloorLayoutBody(
      title: Text(S.current.capture),
      actions: useDesktopLayout ? null : [buildConfirmButton()],
      sideChildren: useDesktopLayout
          ? [
              FloorTransparentButton(
                text: S.current.back,
                iconData: Icons.chevron_left,
                onPressed: Navigator.of(context).pop,
              ),
              Divider(),
              buildHeaderButton(),
              buildTableButton(),
              Divider(),
              buildConfirmButton(),
            ]
          : [],
      bottomNavigationBar: useDesktopLayout
          ? null
          : SizedBox(
              height: AppSizes.kComponentHeight + AppSizes.kSmallGap,
              child: RowGap(
                gap: AppSizes.kSmallGap,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloorButton(
                    iconData: Icons.branding_watermark,
                    type: _selectionType == SelectionType.header ? FloorButtonType.filled : FloorButtonType.outlined,
                    foregroundColor: _selectionType == SelectionType.header ? Color(0xFF212121) : null,
                    backgroundColor: _selectionType == SelectionType.header ? Colors.orange : null,
                    text: S.current.header,
                    onPressed: () {
                      _selectionType = SelectionType.header;
                      setState(() {});
                    },
                  ),
                  FloorButton(
                    iconData: Icons.table_rows,
                    type: _selectionType == SelectionType.table ? FloorButtonType.filled : FloorButtonType.outlined,
                    foregroundColor: _selectionType == SelectionType.table ? Colors.white : null,
                    backgroundColor: _selectionType == SelectionType.table ? Colors.blue : null,
                    text: S.current.table,
                    onPressed: () {
                      _selectionType = SelectionType.table;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final containerSize = Size(constraints.maxWidth, constraints.maxHeight);
          final imageAspectRatio = _image.width / _image.height;
          final containerAspectRatio = containerSize.width / containerSize.height;

          double imageWidth, imageHeight;
          if (imageAspectRatio > containerAspectRatio) {
            imageWidth = containerSize.width;
            imageHeight = containerSize.width / imageAspectRatio;
          } else {
            imageHeight = containerSize.height;
            imageWidth = containerSize.height * imageAspectRatio;
          }

          final imageRect = Rect.fromLTWH(
            (containerSize.width - imageWidth) / 2,
            (containerSize.height - imageHeight) / 2,
            imageWidth,
            imageHeight,
          );

          void resizeSelectionPaint(_SelectionPaint selectionPaint) {
            if (_oldImageRect != null && selectionPaint.isSet) {
              final selectionRect = MathHelper.applyTransformToSelection(
                oldRect: _oldImageRect!.translateToOrigin(),
                newRect: imageRect.translateToOrigin(),
                selectionRect: Rect.fromLTRB(
                  selectionPaint.startDrag!.dx - _oldImageRect!.left,
                  selectionPaint.startDrag!.dy - _oldImageRect!.top,
                  selectionPaint.endDrag!.dx - _oldImageRect!.left,
                  selectionPaint.endDrag!.dy - _oldImageRect!.top,
                ),
              );
              selectionPaint.startDrag = Offset(selectionRect.left + imageRect.left, selectionRect.top + imageRect.top);
              selectionPaint.endDrag = Offset(selectionRect.right + imageRect.left, selectionRect.bottom + imageRect.top);
            }
          }

          if (!_isFirstBuild) {
            resizeSelectionPaint(_tableSelection);
            resizeSelectionPaint(_headerSelection);
          }
          _oldImageRect = imageRect;

          if (_isFirstBuild) WidgetsBinding.instance.addPostFrameCallback((_) => _initSelection());

          return GestureDetector(
            onPanStart: (details) {
              if (imageRect.contains(details.localPosition))
                setState(() {
                  _currentSelectionPaint.startDrag = details.localPosition;
                  _currentSelectionPaint.endDrag = details.localPosition;
                });
            },
            onPanUpdate: (details) => setState(() {
              _currentSelectionPaint.endDrag = Offset(
                details.localPosition.dx.clamp(imageRect.left, imageRect.right),
                details.localPosition.dy.clamp(imageRect.top, imageRect.bottom),
              );
            }),
            onTapDown: (details) => setState(() {
              _currentSelectionPaint.startDrag = null;
              _currentSelectionPaint.endDrag = null;
            }),
            child: CustomPaint(
              size: containerSize,
              painter: SelectionPainter(
                image: _image,
                imageRect: imageRect,
                headerSelection: _isFirstBuild ? null : _headerSelection,
                tableSelection: _isFirstBuild ? null : _tableSelection,
              ),
            ),
          );
        },
      ),
    );
  }
}

class SelectionPainter extends CustomPainter {
  final ui.Image image;
  final Rect imageRect;
  final _SelectionPaint? headerSelection;
  final _SelectionPaint? tableSelection;

  SelectionPainter({
    required this.image,
    required this.imageRect,
    required this.headerSelection,
    required this.tableSelection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    void drawSelectionRect(_SelectionPaint selectionPaint) {
      if (selectionPaint.isSet) {
        final rect = Rect.fromPoints(selectionPaint.startDrag!, selectionPaint.endDrag!);
        if (rect.area > 0) {
          final selectionCanvasPaint = Paint()
            ..color = selectionPaint.color.withOpacity(0.3)
            ..style = PaintingStyle.fill;
          final borderPaint = Paint()
            ..color = selectionPaint.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0;

          canvas.drawRect(rect, selectionCanvasPaint);
          canvas.drawRect(rect, borderPaint);
        }
      }
    }

    final srcRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final paint = Paint();
    canvas.drawImageRect(image, srcRect, imageRect, paint);
    if (headerSelection != null) drawSelectionRect(headerSelection!);
    if (tableSelection != null) drawSelectionRect(tableSelection!);
  }

  @override
  bool shouldRepaint(_) => true;
}
