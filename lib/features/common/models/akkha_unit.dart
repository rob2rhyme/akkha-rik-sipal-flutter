// lib/features/common/models/akkha_unit.dart

enum AkkhaUnitType { vowel, consonant, matra, symbol, number, punctuation }

class AkkhaUnit {
  final String id;
  final String character;
  final AkkhaUnitType type;
  final String transliteration;
  final String hindiTransliteration; // ← new field
  final String? description;
  final String? strokeOrderAsset;
  final String? audioAsset;

  const AkkhaUnit({
    required this.id,
    required this.character,
    required this.type,
    required this.transliteration,
    required this.hindiTransliteration, // ← new in constructor
    this.description,
    this.strokeOrderAsset,
    this.audioAsset,
  });

  factory AkkhaUnit.fromJson(Map<String, dynamic> json) {
    return AkkhaUnit(
      id: json['id'] as String,
      character: json['character'] as String,
      type: AkkhaUnitType.values.firstWhere(
        (e) => e.toString() == 'AkkhaUnitType.${json['type']}',
      ),
      transliteration: json['transliteration'] as String,
      hindiTransliteration:
          json['hindiTransliteration'] as String, // ← parse it
      description: json['description'] as String?,
      strokeOrderAsset: json['strokeOrderAsset'] as String?,
      audioAsset: json['audioAsset'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'character': character,
    'type': type.toString().split('.').last,
    'transliteration': transliteration,
    'hindiTransliteration': hindiTransliteration, // ← serialize it
    'description': description,
    'strokeOrderAsset': strokeOrderAsset,
    'audioAsset': audioAsset,
  };
}
