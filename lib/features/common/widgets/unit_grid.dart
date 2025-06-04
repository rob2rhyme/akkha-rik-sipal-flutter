// lib/features/common/widgets/unit_grid.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

/// A 3-column grid that displays:
///   1) The PUA-mapped Akkha Lipi glyph (in your custom font),
///   2) The Roman transliteration (in the default system font).
///
/// It never calls `unit.character`, so no emojis will appear.
class UnitGrid extends StatelessWidget {
  /// The list of AkkhaUnit objects to display.
  final List<AkkhaUnit> units;

  /// A PageStorageKey to preserve scroll position (one per section).
  final PageStorageKey storageKey;

  /// The starting PUA codepoint for this section:
  ///   • Consonants: 0xE001
  ///   • Vowels:     0xE020
  ///   • Numbers:    0xE040
  ///   • Punctuation:0xE050
  final int baseCode;

  const UnitGrid({
    Key? key,
    required this.units,
    required this.storageKey,
    this.baseCode = 0xE001, // default to “consonants”
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Style for the PUA glyph (AkkhaLip i font):
    const akkhaStyle = TextStyle(
      fontFamily: 'GurbachhanAkkhaLipi', //keep it tight
      fontSize: 48,
    );

    // Style for the Roman transliteration:
    final romanStyle = Theme.of(context).textTheme.bodyMedium!;

    // (Optional) Style for a small gray “Unicode fallback” at the bottom.
    // If you do not want any fallback, you can delete the last Text widget.
    final fallbackStyle = Theme.of(
      context,
    ).textTheme.bodySmall!.copyWith(color: Colors.grey);

    return GridView.builder(
      key: storageKey,
      padding: const EdgeInsets.all(16),
      itemCount: units.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // three cards per row
        mainAxisSpacing: 16, // vertical gap
        crossAxisSpacing: 16, // horizontal gap
        childAspectRatio: 0.65, // cards slightly taller
      ),
      itemBuilder: (context, index) {
        final unit = units[index];
        final codePoint = baseCode + index;
        final puaChar = String.fromCharCode(codePoint);

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1) Render the PUA Akkha glyph:
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(puaChar, style: akkhaStyle),
                  ),
                ),

                const SizedBox(height: 6),

                // 2) Render the Roman transliteration:
                Text(unit.transliteration, style: romanStyle),

                const SizedBox(height: 4),

                // 3) (Optional) Render the “Unicode fallback” (e.g. Devanagari) in gray.
                //    If you do not want any fallback, delete this Text entirely.
                Text(unit.character, style: fallbackStyle),
              ],
            ),
          ),
        );
      },
    );
  }
}
