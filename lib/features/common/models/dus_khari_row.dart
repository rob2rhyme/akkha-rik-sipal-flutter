// lib/features/common/models/dus_khari_row.dart

class DusKhariRow {
  final String baseChar;
  final List<String> syllables;

  DusKhariRow({required this.baseChar, required this.syllables});

  factory DusKhariRow.fromJson(Map<String, dynamic> json) {
    return DusKhariRow(
      baseChar: json['baseChar'] as String,
      syllables: List<String>.from(json['syllables'] as List<dynamic>),
    );
  }
}
