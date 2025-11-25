import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:svapna/app.dart';
import 'package:svapna/l10n/app_localizations.dart';
import 'package:svapna/models/shared_prefs.dart';
import 'package:svapna/providers/bookmarks_provider.dart';
import 'package:svapna/providers/history_provider.dart';
import 'package:svapna/providers/language_provider.dart';
import 'package:svapna/providers/theme_provider.dart';

void main() async {
  await SharedPrefs.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => BookmarksProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Svapna — សប្តិ',
      locale: languageProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LanguageProvider.supportedLocales,
      themeMode: Provider.of<ThemeProvider>(context).currentTheme,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        fontFamily: 'Inter',
        fontFamilyFallback: ['Kantumruy Pro'],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.deepPurple,
        fontFamily: 'Inter',
        fontFamilyFallback: ['Kantumruy Pro'],
      ),
      home: const App(),
    );
  }
}
