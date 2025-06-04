// lib/features/common/data/sectional_akkha_unit_data_source.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

class SectionalAkkhaUnitDataSource {
  Future<List<AkkhaUnit>> loadConsonants() =>
      _loadSection('assets/data/sections/consonants.json');

  Future<List<AkkhaUnit>> loadVowels() =>
      _loadSection('assets/data/sections/vowels.json');

  Future<List<AkkhaUnit>> loadMatras() =>
      _loadSection('assets/data/sections/matras.json');

  Future<List<AkkhaUnit>> loadSymbols() =>
      _loadSection('assets/data/sections/symbols.json');

  Future<List<AkkhaUnit>> loadNumbers() =>
      _loadSection('assets/data/sections/numbers.json');

  Future<List<AkkhaUnit>> loadPunctuation() =>
      _loadSection('assets/data/sections/punctuation.json');

  /// Generic loader for any section JSON file returning a List<AkkhaUnit>.
  Future<List<AkkhaUnit>> _loadSection(String assetPath) async {
    final jsonStr = await rootBundle.loadString(assetPath);
    final List<dynamic> list = json.decode(jsonStr) as List<dynamic>;
    return list
        .cast<Map<String, dynamic>>()
        .map((m) => AkkhaUnit.fromJson(m))
        .toList();
  }
}
