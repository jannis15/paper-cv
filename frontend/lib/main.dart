import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectionCanvas(),
    );
  }
}

class SelectionCanvas extends StatefulWidget {
  @override
  _SelectionCanvasState createState() => _SelectionCanvasState();
}

class _SelectionCanvasState extends State<SelectionCanvas> {
  Offset? _startDrag;
  Offset? _currentDrag;
  Offset? _finalStartDrag;
  Offset? _finalCurrentDrag;
  ui.Image? _image;
  Rect? _imageBounds;

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
    });
  }

  Future<ui.Image?> cropImage() async {
    if (_image == null || _finalStartDrag == null || _finalCurrentDrag == null) {
      return null;
    }

    final left = _finalStartDrag!.dx;
    final top = _finalStartDrag!.dy;
    final right = _finalCurrentDrag!.dx;
    final bottom = _finalCurrentDrag!.dy;

    if (left >= right || top >= bottom) {
      return null;
    }

    final srcRect = Rect.fromLTWH(
      left,
      top,
      right - left,
      bottom - top,
    );

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint();
    canvas.drawImageRect(
      _image!,
      srcRect,
      Rect.fromLTWH(0, 0, srcRect.width, srcRect.height),
      paint,
    );

    final picture = recorder.endRecording();
    return picture.toImage(srcRect.width.toInt(), srcRect.height.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rectangle Selection Canvas')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanStart: (details) {
              if (_imageBounds?.contains(details.localPosition) ?? false) {
                setState(() {
                  _startDrag = details.localPosition;
                  _currentDrag = details.localPosition;
                  _finalStartDrag = null;
                  _finalCurrentDrag = null;
                });
              }
            },
            onPanUpdate: (details) {
              if (_imageBounds?.contains(details.localPosition) ?? false) {
                setState(() {
                  // Clamp the drag position to the image bounds
                  _currentDrag = Offset(
                    details.localPosition.dx.clamp(_imageBounds!.left, _imageBounds!.right),
                    details.localPosition.dy.clamp(_imageBounds!.top, _imageBounds!.bottom),
                  );
                });
              } else {
                // If the position is outside the image bounds, clamp the position to the image edges
                setState(() {
                  _currentDrag = Offset(
                    details.localPosition.dx.clamp(_imageBounds!.left, _imageBounds!.right),
                    details.localPosition.dy.clamp(_imageBounds!.top, _imageBounds!.bottom),
                  );
                });
              }
            },
            onPanEnd: (details) {
              if (_startDrag != null && _currentDrag != null) {
                setState(() {
                  _finalStartDrag = _startDrag;
                  _finalCurrentDrag = _currentDrag;
                });
              }

              setState(() {
                _startDrag = null;
                _currentDrag = null;
              });
            },
            onTapDown: (details) {
              setState(() {
                _finalStartDrag = null;
                _finalCurrentDrag = null;
              });
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: SelectionPainter(
                image: _image,
                containerSize: Size(constraints.maxWidth, constraints.maxHeight),
                startDrag: _startDrag,
                currentDrag: _currentDrag,
                finalStartDrag: _finalStartDrag,
                finalCurrentDrag: _finalCurrentDrag,
                onImageBoundsCalculated: (bounds) {
                  _imageBounds = bounds;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class SelectionPainter extends CustomPainter {
  final ui.Image? image;
  final Size containerSize;
  final Offset? startDrag;
  final Offset? currentDrag;
  final Offset? finalStartDrag;
  final Offset? finalCurrentDrag;
  final void Function(Rect bounds)? onImageBoundsCalculated;

  SelectionPainter({
    required this.image,
    required this.containerSize,
    required this.startDrag,
    required this.currentDrag,
    required this.finalStartDrag,
    required this.finalCurrentDrag,
    this.onImageBoundsCalculated,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      final imageAspectRatio = image!.width / image!.height;
      final containerAspectRatio = containerSize.width / containerSize.height;

      double imageWidth, imageHeight;
      if (imageAspectRatio > containerAspectRatio) {
        imageWidth = containerSize.width;
        imageHeight = containerSize.width / imageAspectRatio;
      } else {
        imageHeight = containerSize.height;
        imageWidth = containerSize.height * imageAspectRatio;
      }

      final paint = Paint();
      final srcRect = Rect.fromLTWH(0, 0, image!.width.toDouble(), image!.height.toDouble());
      final dstRect = Rect.fromLTWH(
        (containerSize.width - imageWidth) / 2,
        (containerSize.height - imageHeight) / 2,
        imageWidth,
        imageHeight,
      );

      canvas.drawImageRect(image!, srcRect, dstRect, paint);

      if (onImageBoundsCalculated != null) {
        onImageBoundsCalculated!(dstRect);
      }

      if (startDrag != null && currentDrag != null) {
        final rect = Rect.fromPoints(startDrag!, currentDrag!);
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

      if (finalStartDrag != null && finalCurrentDrag != null) {
        final rect = Rect.fromPoints(finalStartDrag!, finalCurrentDrag!);
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
