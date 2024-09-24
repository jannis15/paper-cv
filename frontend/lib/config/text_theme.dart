import 'package:flutter/material.dart';

class FloorTextTheme extends TextTheme {
  static const String? _fontFamily = 'Atkinson Hyperlegible';

  const FloorTextTheme()
      : super(
          displayLarge: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 64 / 57, fontSize: 57, letterSpacing: -0.25),
          displayMedium: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 52 / 45, fontSize: 45),
          displaySmall: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 44 / 36, fontSize: 36),
          headlineLarge: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 40 / 32, fontSize: 32),
          headlineMedium: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 36 / 28, fontSize: 28),
          headlineSmall: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 32 / 24, fontSize: 24),
          titleLarge: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 28 / 22, fontSize: 22),
          titleMedium: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 24 / 16, fontSize: 16, letterSpacing: 0.15),
          titleSmall: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 20 / 14, fontSize: 14, letterSpacing: 0.1),
          bodyLarge: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 24 / 16, fontSize: 16, letterSpacing: 0.5),
          bodyMedium: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 20 / 14, fontSize: 14, letterSpacing: 0.25),
          bodySmall: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 16 / 12, fontSize: 12, letterSpacing: 0.4),
          labelLarge: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 20 / 14, fontSize: 14, letterSpacing: 0.1),
          labelMedium: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 16 / 12, fontSize: 12, letterSpacing: 0.5),
          labelSmall: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, height: 16 / 11, fontSize: 11, letterSpacing: 0.5),
        );
}
