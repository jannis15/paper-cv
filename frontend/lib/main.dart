import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:paper_cv/utils/math_utils.dart';
import 'package:paper_cv/utils/rect_extension.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ImageLoader());
  }
}

class ImageLoader extends StatefulWidget {
  const ImageLoader({super.key});

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  bool _isLoading = true;
  late ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final data = await DefaultAssetBundle.of(context).load('assets/example.jpg');
    final list = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(list);
    final frame = await codec.getNextFrame();
    setState(() {
      _image = frame.image;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Placeholder() : SelectionCanvas(image: _image);
  }
}

class SelectionCanvas extends StatefulWidget {
  final ui.Image image;

  const SelectionCanvas({required this.image});

  @override
  _SelectionCanvasState createState() => _SelectionCanvasState();
}

class _SelectionCanvasState extends State<SelectionCanvas> {
  late ui.Image _image = widget.image;
  Offset? _startDrag;
  Offset? _endDrag;
  Rect? _oldImageRect;

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
      appBar: AppBar(title: Text('Rectangle Selection Canvas')),
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

    if (startDrag != null && endDrag != null) {
      final rect = Rect.fromPoints(startDrag!, endDrag!);
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

  @override
  bool shouldRepaint(_) => true;
}
