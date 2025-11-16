import 'package:flutter/material.dart';

import 'package:svapna/models/shared_prefs.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = getThemeModeFromString(SharedPrefs.instance.theme);

  setTheme(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.system:
        SharedPrefs.instance.theme = 'system';
      case ThemeMode.light:
        SharedPrefs.instance.theme = 'light';
      case ThemeMode.dark:
        SharedPrefs.instance.theme = 'dark';
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
