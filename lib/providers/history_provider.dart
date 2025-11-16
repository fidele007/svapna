import 'package:flutter/material.dart';

import 'package:svapna/models/dream.dart';
import 'package:svapna/models/shared_prefs.dart';

class HistoryProvider extends ChangeNotifier {
  List<Dream> get history => SharedPrefs.instance.getHistory();

  Future<void> addHistory(Dream dream) async {
    await SharedPrefs.instance.addHistory(dream);
    notifyListeners();
  }
}
