import 'package:flutter/material.dart';

import 'package:svapna/models/dream.dart';
import 'package:svapna/models/pref.dart';

class BookmarksProvider extends ChangeNotifier {
  List<Dream> get bookmarks => Pref.instance.getBookmarks();

  void addBookmark(Dream dream) {
    Pref.instance.addBookmark(dream);
    notifyListeners();
  }

  void removeBookmark(Dream dream) {
    Pref.instance.removeBookmark(dream);
    notifyListeners();
  }
}
