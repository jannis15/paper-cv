import 'package:flutter/material.dart';

enum SupportedLocale {
  en,
  de;

  String get key => switch (this) {
        SupportedLocale.en => 'en',
        SupportedLocale.de => 'de',
      };

  Locale get locale => Locale(key);

  String get title => switch (this) {
        SupportedLocale.en => 'English',
        SupportedLocale.de => 'Deutsch',
      };
}
