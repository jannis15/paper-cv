part of '../floor_camera.dart';

class CameraRectangularOverlayPainter extends CustomPainter {
  final double aspectRatio;
  final BuildContext context;

  CameraRectangularOverlayPainter(this.context, {required this.aspectRatio});

  @override
  void paint(Canvas canvas, Size size) => paintCameraOverlay(aspectRatio, canvas, size);

  @override
  bool shouldRepaint(_) => false;
}
