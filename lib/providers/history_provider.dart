import 'package:flutter/material.dart';

import 'package:svapna/models/dream.dart';
import 'package:svapna/models/pref.dart';

class HistoryProvider extends ChangeNotifier {
  List<Dream> get history => Pref.instance.getHistory();

  void addHistory(Dream dream) {
    Pref.instance.addHistory(dream);
    notifyListeners();
  }
}
