import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import 'dream.dart';

class Pref {
  static final theme = 'light'.val('theme');
  static final language = 'kh'.val('language');

  static final Pref instance = Pref();

  final history = [].val('history');
  final bookmarks = [].val('bookmarks');

  final maxHistoryItems = 50;

  List<Dream> getBookmarks() {
    final List<dynamic> currentBookmarks = bookmarks.val;
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

  List<Dream> getHistory() {
    final List<dynamic> currentHistory = history.val;
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

  void addBookmark(Dream dream) {
    final List<dynamic> currentBookmarks = bookmarks.val;
    currentBookmarks.add(dream.toJson());

    bookmarks.val = currentBookmarks;
  }

  removeBookmark(Dream dream) {
    final List<dynamic> currentBookmarks = bookmarks.val;
    currentBookmarks.removeWhere((element) => element['id'] == dream.id);

    bookmarks.val = currentBookmarks;
  }

  addHistory(Dream dream) {
    final List<dynamic> currentHistory = history.val;
    currentHistory.removeWhere((element) => element['id'] == dream.id);
    currentHistory.insert(0, dream.toJson());

    // Limit history to last 50 items
    if (currentHistory.length > maxHistoryItems) {
      currentHistory.removeRange(maxHistoryItems, currentHistory.length);
    }

    history.val = currentHistory;
  }
}
