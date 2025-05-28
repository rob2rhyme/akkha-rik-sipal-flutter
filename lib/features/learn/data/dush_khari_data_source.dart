// lib/features/learn/data/dush_khari_data_source.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../common/models/dus_khari_row.dart';
import '../data/sectional_akkha_unit_data_source.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

class DusKhariDataSource {
  static const _assetPath = 'assets/data/sections/dushKhari.json';

  /// Loads the 10-Khari rows from the JSON asset and enriches them
  /// with transliteration data via a lookup map.
  Future<List<DusKhariRow>> loadDusKhari() async {
    final jsonStr = await rootBundle.loadString(_assetPath);
    final List<dynamic> list = json.decode(jsonStr) as List<dynamic>;

    // Build a lookup map from character → AkkhaUnit
    final ds = SectionalAkkhaUnitDataSource();
    final consonants = await ds.loadConsonants();
    final vowels = await ds.loadVowels();
    final matras = await ds.loadMatras();
    final symbols = await ds.loadSymbols();
    // You can include numbers/punctuation here if you want them in lookup
    final allUnits = <AkkhaUnit>[
      ...consonants,
      ...vowels,
      ...matras,
      ...symbols,
    ];
    final lookup = {for (var u in allUnits) u.character: u};

    // Parse each row, passing the lookup
    return list
        .map((e) => DusKhariRow.fromJson(e as Map<String, dynamic>, lookup))
        .toList();
  }
}
