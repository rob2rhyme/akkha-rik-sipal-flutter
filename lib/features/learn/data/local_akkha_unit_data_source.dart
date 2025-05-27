// lib/features/learn/data/local_akkha_unit_data_source.dart

import 'dart:convert';
import 'package:flutter/foundation.dart'; // ← add this
import 'package:flutter/services.dart' show rootBundle;
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

/// Loads [AkkhaUnit]s from the bundled JSON asset.
class LocalAkkhaUnitDataSource {
  /// Reads the JSON and returns a list of parsed units.
  Future<List<AkkhaUnit>> loadAkkhaUnits() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/akkha_units.json',
      );
      final List<dynamic> decoded = json.decode(jsonString) as List<dynamic>;
      return decoded
          .map((e) => AkkhaUnit.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, st) {
      // debugPrint is now available
      debugPrint('Error loading AkkhaUnits: $e\n$st');
      return [];
    }
  }
}
