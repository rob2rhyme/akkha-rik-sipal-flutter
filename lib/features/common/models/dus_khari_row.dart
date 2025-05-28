// lib/features/common/models/dus_khari_row.dart

import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

/// A single 10-Khari row: one base consonant + its list of vowel-forms.
class DusKhariRow {
  final AkkhaUnit baseUnit;
  final List<AkkhaUnit> syllableUnits;

  DusKhariRow({required this.baseUnit, required this.syllableUnits});

  /// Build from JSON + a lookup map of character → AkkhaUnit.
  /// Falls back to `AkkhaUnit.fromJson(...)` so we always satisfy its
  /// required `id` and `type` parameters.
  factory DusKhariRow.fromJson(
    Map<String, dynamic> json,
    Map<String, AkkhaUnit> lookup,
  ) {
    // 1) Base character – must be a non-null String
    final baseChar =
        (json['baseChar'] as String?) ??
        (throw FormatException('Missing baseChar in $json'));

    final baseUnit =
        lookup[baseChar] ??
        AkkhaUnit.fromJson({
          'id': baseChar,
          'type': 'unknown',
          'character': baseChar,
          'transliteration': '',
          'hindiTransliteration': '',
        });

    // 2) Syllables – might be missing, so default to empty list
    final rawEntries = (json['syllables'] as List<dynamic>?) ?? [];
    final syllUnits = rawEntries.map((entry) {
      if (entry is String) {
        return lookup[entry] ??
            AkkhaUnit.fromJson({
              'id': entry,
              'type': 'unknown',
              'character': entry,
              'transliteration': '',
              'hindiTransliteration': '',
            });
      } else if (entry is Map<String, dynamic>) {
        return AkkhaUnit.fromJson(entry);
      } else {
        // completely unexpected shape
        throw FormatException('Invalid syllable entry: $entry');
      }
    }).toList();

    return DusKhariRow(baseUnit: baseUnit, syllableUnits: syllUnits);
  }
}
