import 'dart:ui';
import '../models/floor_models.dart';

extension SelectionExtension on Selection {
  Rect toTRect() => Rect.fromLTRB(this.tX1!, this.tY1!, this.tX2!, this.tY2!);

  Rect toHRect() => Rect.fromLTRB(this.hX1!, this.hY1!, this.hX2!, this.hY2!);
}
