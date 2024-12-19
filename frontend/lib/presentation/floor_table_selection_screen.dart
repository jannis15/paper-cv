import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:paper_cv/utils/math_utils.dart';
import 'package:paper_cv/utils/rect_extension.dart';
import 'package:paper_cv/utils/widget_utils.dart';

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

class _FloorTableSelectionScreenState extends State<FloorTableSelectionScreen> {
  late ui.Image _image = widget.image;
  Offset? _startDrag;
  Offset? _endDrag;
  Rect? _oldImageRect;

  @override
  void initState() {
    super.initState();
    final selection = widget.document.selections[widget.file];
    if (selection != null) {
      _startDrag = ui.Offset(selection.x1, selection.y1);
      _endDrag = ui.Offset(selection.x2, selection.y2);
    }
  }

  // Future<ui.Image?> cropImage() async {
  //   if (_startDrag == null || _currentDrag == null) {
  //     return null;
  //   }
  //
  //   final left = _startDrag!.dx;
  //   final top = _startDrag!.dy;
  //   final right = _currentDrag!.dx;
  //   final bottom = _currentDrag!.dy;
  //
  //   if (left >= right || top >= bottom) {
  //     return null;
  //   }
  //
  //   final srcRect = Rect.fromLTWH(
  //     left,
  //     top,
  //     right - left,
  //     bottom - top,
  //   );
  //
  //   final recorder = ui.PictureRecorder();
  //   final canvas = Canvas(recorder);
  //
  //   final paint = Paint();
  //   canvas.drawImageRect(
  //     _image,
  //     srcRect,
  //     Rect.fromLTWH(0, 0, srcRect.width, srcRect.height),
  //     paint,
  //   );
  //
  //   final picture = recorder.endRecording();
  //   return picture.toImage(srcRect.width.toInt(), srcRect.height.toInt());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FloorAppBar(
        backgroundColor: colorScheme.surface,
        actions: [
          FloorOutlinedButton(
            iconData: Icons.check,
            text: 'Bestätigen',
            onPressed: () {
              Selection? selection = widget.document.selections[widget.file];
              bool shouldAssign = _startDrag != null &&
                  _endDrag != null &&
                  (selection == null ||
                      (selection.x1 != _startDrag!.dx ||
                          selection.y1 != _startDrag!.dy ||
                          selection.x2 != _endDrag!.dx ||
                          selection.y2 != _endDrag!.dy));
              if (shouldAssign) {
                if (selection == null) {
                  widget.document.selections[widget.file] = Selection(
                    x1: _startDrag!.dx,
                    y1: _startDrag!.dy,
                    x2: _endDrag!.dx,
                    y2: _endDrag!.dy,
                  );
                } else {
                  selection
                    ..x1 = _startDrag!.dx
                    ..y1 = _startDrag!.dy
                    ..x2 = _endDrag!.dx
                    ..y2 = _endDrag!.dy;
                }
              } else if (_startDrag == null && _endDrag == null && selection != null) {
                widget.document.selections.remove(widget.file);
                shouldAssign = true;
              }
              Navigator.of(context).pop<bool>(shouldAssign);
            },
          )
        ],
      ),
      body: LayoutBuilder(
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

          if (_startDrag != null && _endDrag != null && _oldImageRect != null) {
            final selectionRect = MathHelper.applyTransformToSelection(
              oldRect: _oldImageRect!.translateToOrigin(),
              newRect: imageRect.translateToOrigin(),
              selectionRect: Rect.fromLTRB(
                _startDrag!.dx - _oldImageRect!.left,
                _startDrag!.dy - _oldImageRect!.top,
                _endDrag!.dx - _oldImageRect!.left,
                _endDrag!.dy - _oldImageRect!.top,
              ),
            );
            _startDrag = Offset(selectionRect.left + imageRect.left, selectionRect.top + imageRect.top);
            _endDrag = Offset(selectionRect.right + imageRect.left, selectionRect.bottom + imageRect.top);
          }
          _oldImageRect = imageRect;

          return GestureDetector(
            onPanStart: (details) {
              if (imageRect.contains(details.localPosition))
                setState(() {
                  _startDrag = details.localPosition;
                  _endDrag = details.localPosition;
                });
            },
            onPanUpdate: (details) => setState(() {
              _endDrag = Offset(
                details.localPosition.dx.clamp(imageRect.left, imageRect.right),
                details.localPosition.dy.clamp(imageRect.top, imageRect.bottom),
              );
            }),
            onPanEnd: (details) {
              if (_startDrag != null && _endDrag != null)
                setState(() {
                  _startDrag = _startDrag;
                  _endDrag = _endDrag;
                });
            },
            onTapDown: (details) => setState(() {
              _startDrag = null;
              _endDrag = null;
            }),
            child: CustomPaint(
              size: containerSize,
              painter: SelectionPainter(
                image: _image,
                imageRect: imageRect,
                startDrag: _startDrag,
                endDrag: _endDrag,
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
  final Offset? startDrag;
  final Offset? endDrag;

  SelectionPainter({
    required this.image,
    required this.imageRect,
    required this.startDrag,
    required this.endDrag,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final srcRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final paint = Paint();
    canvas.drawImageRect(image, srcRect, imageRect, paint);
    if (startDrag != null && endDrag != null) {
      final rect = Rect.fromPoints(startDrag!, endDrag!);
      if (rect.area > 0) {
        final selectionPaint = Paint()
          ..color = Colors.blue.withOpacity(0.3)
          ..style = PaintingStyle.fill;
        final borderPaint = Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

        canvas.drawRect(rect, selectionPaint);
        canvas.drawRect(rect, borderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => true;
}
