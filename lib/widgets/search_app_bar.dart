import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:svapna/i18n/app_localizations.dart';
import 'package:svapna/models/language.dart';
import 'package:svapna/providers/language_provider.dart';
import 'package:svapna/providers/theme_provider.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;
  final SearchController searchController;
  final Function(String)? onSearch;
  final Function(BuildContext, SearchController)? onSuggestions;

  const SearchAppBar({
    super.key,
    required this.searchController,
    this.title,
    this.onSearch,
    this.onSuggestions,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
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
    final bool shouldHaveSearchBar = widget.onSearch != null;
    return AppBar(
      leading: shouldHaveSearchBar ? widget.title : null,
      centerTitle: shouldHaveSearchBar,
      title: shouldHaveSearchBar
          ? SearchAnchor.bar(
              constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: 600.0,
                minHeight: 40.0,
              ),
              barShape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              viewShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onSubmitted: (value) {
                widget.onSearch?.call(value);
                setState(() {
                  if (value.isNotEmpty) {
                    widget.searchController.closeView(value);
                  }
                });
              },
              searchController: widget.searchController,
              barHintText: AppLocalizations.of(context)!.searchDreams,
              suggestionsBuilder: (context, controller) {
                return widget.onSuggestions?.call(context, controller) ?? [];
              },
            )
          : widget.title,
      actions: [
        MenuAnchor(
          menuChildren: <Widget>[
            ...LanguageProvider.supportedLocales.map(
              (locale) => MenuItemButton(
                onPressed: () {
                  context.read<LanguageProvider>().setLocale(locale);
                  widget.onSearch?.call(widget.searchController.text.trim());
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
