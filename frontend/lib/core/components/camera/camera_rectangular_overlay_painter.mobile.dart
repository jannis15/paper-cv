import 'dart:math';

import 'package:flutter/material.dart';

import '../floor_camera.dart';

void paintCameraOverlay(double aspectRatio, Canvas canvas, Size size) {
  final double overlayHeight = size.height - (cameraFeedOverlayMargin * 2);
  final double overlayWidth = overlayHeight * (1 / aspectRatio);
  final Point topLeft = Point((size.width / 2) - (overlayWidth / 2), (size.height / 2) - (overlayHeight / 2));

  canvas.drawPath(
    Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()..addRect(Rect.fromLTWH(topLeft.x as double, topLeft.y as double, overlayWidth, overlayHeight)),
    ),
    Paint()..color = Colors.black.withOpacity(.5),
  );

  final Paint borderPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  final Rect holeRect = Rect.fromLTWH(topLeft.x as double, topLeft.y as double, overlayWidth, overlayHeight);

  canvas.drawRect(holeRect, borderPaint);
}
