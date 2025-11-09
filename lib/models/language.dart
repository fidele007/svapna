import 'package:flutter/material.dart';

extension LocaleDisplayName on Locale {
  String get displayName {
    switch (languageCode) {
      case 'km':
        return 'ខ្មែរ';
      case 'en':
        return 'English';
      default:
        return languageCode;
    }
  }
}

enum Language { khmer, english }

extension LanguageExtension on Language {
  String get code {
    switch (this) {
      case Language.khmer:
        return 'kh';
      case Language.english:
        return 'en';
    }
  }

  String get displayName {
    switch (this) {
      case Language.khmer:
        return 'ខ្មែរ';
      case Language.english:
        return 'English';
    }
  }
}
