import 'dart:ui';

import 'package:paper_cv/domain/floor_models.dart';

extension RectExtension on Rect {
  Rect translateToOrigin() => Rect.fromLTWH(0, 0, this.width, this.height);

  double get area => this.width * this.height;

  Selection toSelection() => Selection(x1: this.left, x2: this.right, y1: this.top, y2: this.bottom);
}
