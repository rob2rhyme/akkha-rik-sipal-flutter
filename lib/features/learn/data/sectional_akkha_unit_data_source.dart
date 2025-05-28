// lib/features/learn/data/sectional_akkha_unit_data_source.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

/// Loads exactly one section’s JSON at a time from
/// assets/data/sections/<filename>.json
class SectionalAkkhaUnitDataSource {
  Future<List<AkkhaUnit>> _loadSection(String filename) async {
    final jsonString = await rootBundle.loadString(
      'assets/data/sections/$filename',
    );
    final List<dynamic> decoded = json.decode(jsonString) as List<dynamic>;
    return decoded
        .map((e) => AkkhaUnit.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<AkkhaUnit>> loadConsonants() => _loadSection('consonants.json');
  Future<List<AkkhaUnit>> loadVowels() => _loadSection('vowels.json');
  Future<List<AkkhaUnit>> loadMatras() => _loadSection('matras.json');
  Future<List<AkkhaUnit>> loadSymbols() => _loadSection('symbols.json');
  Future<List<AkkhaUnit>> loadNumbers() => _loadSection('numbers.json');
  Future<List<AkkhaUnit>> loadPunctuation() => _loadSection('punctuation.json');
}
