import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:svapna/models/dream.dart';

class SharedPrefs {
  SharedPrefs._();

  static SharedPrefs? _instance;
  static SharedPrefs get instance {
    _instance ??= SharedPrefs._();
    return _instance!;
  }

  static SharedPreferencesWithCache? _prefsWithCache;

  static final String _themeKey = 'theme';
  static final String _languageKey = 'language';
  static final String _historyKey = 'history';
  static final String _bookmarksKey = 'bookmarks';

  final maxHistoryItems = 50;

  static init() async {
    _prefsWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{
          _themeKey,
          _languageKey,
          _historyKey,
          _bookmarksKey
        },
      ),
    );
  }

  String? get theme => _prefsWithCache!.getString(_themeKey) ?? 'system';
  set theme(String? value) => _prefsWithCache!.setString(_themeKey, value!);

  String? get language => _prefsWithCache!.getString(_languageKey) ?? 'km';
  set language(String? value) =>
      _prefsWithCache!.setString(_languageKey, value!);

  List<dynamic> get _bookmarks =>
      _prefsWithCache!
          .getStringList(_bookmarksKey)
          ?.map((e) => jsonDecode(e))
          .toList() ??
      [];

  List<Dream> getBookmarks() {
    final List<dynamic> currentBookmarks = _bookmarks;
    if (currentBookmarks.isEmpty) {
      return [];
    }

    try {
      return currentBookmarks.map((e) => Dream.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error parsing bookmarked dreams: $e');
      return [];
    }
  }

  bool isDreamBookmarked(Dream dream) {
    final List<Dream> currentBookmarks = getBookmarks();
    return currentBookmarks.any((element) => element.id == dream.id);
  }

  Future<void> addBookmark(Dream dream) async {
    final List<dynamic> currentBookmarks = _bookmarks;
    currentBookmarks.add(dream.toJson());

    await _prefsWithCache!.setStringList(
        _bookmarksKey, currentBookmarks.map((e) => jsonEncode(e)).toList());
  }

  Future<void> removeBookmark(Dream dream) async {
    final List<dynamic> currentBookmarks = _bookmarks;
    currentBookmarks.removeWhere((element) => element['id'] == dream.id);

    await _prefsWithCache!.setStringList(
        _bookmarksKey, currentBookmarks.map((e) => jsonEncode(e)).toList());
  }

  List<dynamic> get _history =>
      _prefsWithCache!
          .getStringList(_historyKey)
          ?.map((e) => jsonDecode(e))
          .toList() ??
      [];

  List<Dream> getHistory() {
    final List<dynamic> currentHistory = _history;
    if (currentHistory.isEmpty) {
      return [];
    }

    try {
      return currentHistory.map((e) => Dream.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error parsing recent dreams: $e');
      return [];
    }
  }

  Future<void> addHistory(Dream dream) async {
    final List<dynamic> currentHistory = _history;
    currentHistory.removeWhere((element) => element['id'] == dream.id);
    currentHistory.insert(0, dream.toJson());

    // Limit history to last 50 items
    if (currentHistory.length > maxHistoryItems) {
      currentHistory.removeRange(maxHistoryItems, currentHistory.length);
    }

    await _prefsWithCache!.setStringList(
        _historyKey, currentHistory.map((e) => jsonEncode(e)).toList());
  }
}
