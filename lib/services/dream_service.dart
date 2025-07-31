import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/dream.dart';

class DreamService {
  static final Map<String, List<Dream>> _dreams = {};

  static Future<List<Dream>> getDreams(String languageCode) async {
    if (_dreams[languageCode] != null) {
      return _dreams[languageCode]!;
    }

    String dreamsJsonString;
    try {
      dreamsJsonString =
          await rootBundle.loadString('assets/dreams_$languageCode.json');
    } catch (e) {
      debugPrint(
          'Error loading dreams for $languageCode: $e. Falling back to default dreams.');
      dreamsJsonString = await rootBundle.loadString('assets/dreams_en.json');
    }

    final dreamsJson = jsonDecode(dreamsJsonString);
    final List<Dream> dreams = [];
    for (var dream in dreamsJson['words']) {
      dreams.add(Dream(
        id: dream['id'],
        name: dream['name'],
        definition: dream['definition'],
      ));
    }

    _dreams[languageCode] = dreams;

    return dreams;
  }
}
