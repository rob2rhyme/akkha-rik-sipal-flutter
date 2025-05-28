// lib/features/learn/data/dush_khari_data_source.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../common/models/dus_khari_row.dart';

class DusKhariDataSource {
  static const _assetPath = 'assets/data/sections/dushKhari.json';

  /// Loads the 10Khari rows from the JSON asset
  Future<List<DusKhariRow>> loadDusKhari() async {
    final jsonStr = await rootBundle.loadString(_assetPath);
    final List<dynamic> list = json.decode(jsonStr) as List<dynamic>;
    return list
        .map((e) => DusKhariRow.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
