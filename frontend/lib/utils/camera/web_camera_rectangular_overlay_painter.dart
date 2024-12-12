import 'package:flutter/material.dart';
import 'package:paper_cv/utils/camera/camera_utils.dart';

void paintCameraOverlay(double aspectRatio, Canvas canvas, Size size) {
  final overlayPaint = Paint()
    ..color = Colors.black.withOpacity(0.5)
    ..style = PaintingStyle.fill;

  final borderPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  final overlayHeight = size.height - (cameraFeedOverlayMargin * 2);
  final overlayWidth = overlayHeight * (1 / aspectRatio);

  final topLeft = Offset(
    (size.width / 2) - (overlayWidth / 2),
    (size.height / 2) - (overlayHeight / 2),
  );

  final fullScreenRect = Rect.fromLTWH(0, 0, size.width, size.height);
  canvas.drawRect(fullScreenRect, overlayPaint);

  final overlayRect = Rect.fromLTWH(topLeft.dx, topLeft.dy, overlayWidth, overlayHeight);
  final clearPaint = Paint()..blendMode = BlendMode.clear;
  canvas.drawRect(overlayRect, clearPaint);

  canvas.drawRect(overlayRect, borderPaint);
}
