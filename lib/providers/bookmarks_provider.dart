import 'package:flutter/material.dart';

import 'package:svapna/models/dream.dart';
import 'package:svapna/models/shared_prefs.dart';

class BookmarksProvider extends ChangeNotifier {
  List<Dream> get bookmarks => SharedPrefs.instance.getBookmarks();

  Future<void> addBookmark(Dream dream) async {
    await SharedPrefs.instance.addBookmark(dream);
    notifyListeners();
  }

  Future<void> removeBookmark(Dream dream) async {
    await SharedPrefs.instance.removeBookmark(dream);
    notifyListeners();
  }
}
