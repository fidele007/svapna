import 'package:flutter/material.dart';
import 'package:svapna/models/pref.dart';

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

class LanguageProvider extends ChangeNotifier {
  static List<Locale> get supportedLocales => const [
        Locale('km'),
        Locale('en'),
      ];

  Locale _locale = supportedLocales.firstWhere(
    (x) => x.languageCode == Pref.language.val,
    orElse: () => supportedLocales.first,
  );

  Locale get locale => _locale;

  // Get the next supported locale in the list
  Locale get nextLocale => supportedLocales[
      (supportedLocales.indexOf(_locale) + 1) % supportedLocales.length];

  setLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) {
      return;
    }

    _locale = locale;
    Pref.language.val = locale.languageCode;
    notifyListeners();
  }
}
