import 'package:flutter/material.dart';

import 'package:svapna/models/pref.dart';

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
