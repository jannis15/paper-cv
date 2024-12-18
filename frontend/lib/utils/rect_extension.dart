import 'dart:ui';

extension RectExtension on Rect {
  Rect translateToOrigin() => Rect.fromLTWH(0, 0, this.width, this.height);

  double get area => this.width * this.height;
}
