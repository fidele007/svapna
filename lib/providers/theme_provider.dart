import 'package:flutter/material.dart';

import 'package:svapna/models/pref.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = getThemeModeFromString(Pref.theme.val);

  setTheme(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.system:
        Pref.theme.val = 'system';
      case ThemeMode.light:
        Pref.theme.val = 'light';
      case ThemeMode.dark:
        Pref.theme.val = 'dark';
    }
    currentTheme = theme;

    notifyListeners();
  }

  static ThemeMode getThemeModeFromString(themeString) {
    switch (themeString) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
