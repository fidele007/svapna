import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:svapna/i18n/app_localizations.dart';
import 'package:svapna/models/language.dart';
import 'package:svapna/providers/language_provider.dart';
import 'package:svapna/providers/theme_provider.dart';

class CustomizedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;

  const CustomizedAppBar({super.key, required this.title});

  @override
  State<CustomizedAppBar> createState() => _CustomizedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomizedAppBarState extends State<CustomizedAppBar> {
  late ThemeMode _currentThemeMode;

  @override
  void initState() {
    super.initState();

    setState(() {
      _currentThemeMode = context.read<ThemeProvider>().currentTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      actions: [
        MenuAnchor(
          menuChildren: <Widget>[
            ...LanguageProvider.supportedLocales.map(
              (locale) => MenuItemButton(
                onPressed: () {
                  context.read<LanguageProvider>().setLocale(locale);
                },
                child: Text(locale.displayName),
              ),
            )
          ],
          builder: (context, controller, child) => TextButton.icon(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            label: Text(context.read<LanguageProvider>().locale.displayName),
            icon: Icon(Icons.translate),
          ),
        ),
        MenuAnchor(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setTheme(ThemeMode.system);
                setState(() {
                  _currentThemeMode = ThemeMode.system;
                });
              },
              leadingIcon: getIconForTheme(
                ThemeMode.system,
                _currentThemeMode == ThemeMode.system,
              ),
              child: Text(AppLocalizations.of(context)!.system),
            ),
            MenuItemButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setTheme(ThemeMode.light);
                setState(() {
                  _currentThemeMode = ThemeMode.light;
                });
              },
              leadingIcon: getIconForTheme(
                ThemeMode.light,
                _currentThemeMode == ThemeMode.light,
              ),
              child: Text(AppLocalizations.of(context)!.light),
            ),
            MenuItemButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setTheme(ThemeMode.dark);
                setState(() {
                  _currentThemeMode = ThemeMode.dark;
                });
              },
              leadingIcon: getIconForTheme(
                ThemeMode.dark,
                _currentThemeMode == ThemeMode.dark,
              ),
              child: Text(AppLocalizations.of(context)!.dark),
            ),
          ],
          builder: (context, controller, child) => TextButton.icon(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            label: Text(AppLocalizations.of(context)!.theme),
            icon: getIconForTheme(_currentThemeMode, true),
          ),
        ),
      ],
    );
  }
}

Icon getIconForTheme(ThemeMode themeMode, bool selected) {
  switch (themeMode) {
    case ThemeMode.system:
      return selected
          ? Icon(Icons.brightness_auto)
          : Icon(Icons.brightness_auto_outlined);
    case ThemeMode.light:
      return selected
          ? Icon(Icons.light_mode)
          : Icon(Icons.light_mode_outlined);
    case ThemeMode.dark:
      return selected ? Icon(Icons.dark_mode) : Icon(Icons.dark_mode_outlined);
  }
}
