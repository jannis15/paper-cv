import 'dart:ui';

import 'package:paper_cv/domain/floor_models.dart';

extension SelectionExtension on Selection {
  Rect toRect() => Rect.fromLTRB(this.x1, this.y1, this.x2, this.y2);
}
