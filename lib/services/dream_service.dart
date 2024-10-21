import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/dream.dart';

class DreamService {
  static List<Dream>? _dreams;

  static Future<List<Dream>> get dreams async {
    if (_dreams != null && _dreams!.isNotEmpty) {
      return _dreams!;
    }

    final String dreamsJsonString =
        await rootBundle.loadString('assets/dreams_kh.json');
    final dreamsJson = jsonDecode(dreamsJsonString);
    _dreams = [];
    for (var dream in dreamsJson['words']) {
      _dreams!.add(Dream(
        id: dream['id'],
        name: dream['name'],
        definition: dream['definition'],
      ));
    }

    return _dreams!;
  }
}
