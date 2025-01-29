import 'dart:ui' as ui show Image;

extension UiImageExtension on ui.Image {
  bool get isLandscape => this.width > this.height;
}
