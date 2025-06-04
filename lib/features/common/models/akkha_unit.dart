// lib/features/common/models/akkha_unit.dart

enum AkkhaUnitType {
  vowel,
  consonant,
  number,
  matra,
  symbol,
  punctuation,
  unknown,
}

class AkkhaUnit {
  final String id;
  final String character;
  final AkkhaUnitType type;
  final String transliteration;
  final String hindiTransliteration;
  final String? group; // ← new
  final String? description;
  final String? strokeOrderAsset;
  final String? audioAsset;

  const AkkhaUnit({
    required this.id,
    required this.character,
    required this.type,
    required this.transliteration,
    required this.hindiTransliteration,
    this.group, // ← include in ctor
    this.description,
    this.strokeOrderAsset,
    this.audioAsset,
  });

  factory AkkhaUnit.fromJson(Map<String, dynamic> json) {
    // Safely parse the unit type, defaulting to unknown
    final typeStr = (json['type'] as String?) ?? 'unknown';
    final type = AkkhaUnitType.values.firstWhere(
      (e) => e.toString().split('.').last == typeStr,
      orElse: () => AkkhaUnitType.unknown,
    );

    return AkkhaUnit(
      // If id/character are ever missing, we at least get an empty-string
      id: (json['id'] as String?) ?? '',
      character: (json['character'] as String?) ?? '',
      type: type,
      // These are optional in your JSON, so default to empty
      transliteration: (json['transliteration'] as String?) ?? '',
      hindiTransliteration: (json['hindiTransliteration'] as String?) ?? '',
      // Any extra fields you have in AkkhaUnit (group, description, etc.)
      group: json['group'] as String?,
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
    'hindiTransliteration': hindiTransliteration,
    'group': group, // ← serialize
    'description': description,
    'strokeOrderAsset': strokeOrderAsset,
    'audioAsset': audioAsset,
  };
}
