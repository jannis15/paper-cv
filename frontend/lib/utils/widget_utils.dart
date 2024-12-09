import 'package:flutter/material.dart';
import 'package:paper_cv/config/config.dart';

extension WidgetX on State {
  bool get useDesktopLayout => MediaQuery.of(context).size.width >= AppSizes.kDesktopWidth;

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  TextTheme get textTheme => Theme.of(context).textTheme;
}
