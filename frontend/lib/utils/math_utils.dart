import 'dart:ui';

abstract class MathHelper {
  static Rect applyTransformToSelection({
    required Rect oldRect,
    required Rect newRect,
    required Rect selectionRect,
  }) {
    double scaleX = newRect.width / oldRect.width;
    double scaleY = newRect.height / oldRect.height;

    double translateX = newRect.left - oldRect.left;
    double translateY = newRect.top - oldRect.top;

    Rect transformedSelectionRect = Rect.fromLTWH(
      selectionRect.left * scaleX + translateX,
      selectionRect.top * scaleY + translateY,
      selectionRect.width * scaleX,
      selectionRect.height * scaleY,
    );

    return transformedSelectionRect;
  }
}
