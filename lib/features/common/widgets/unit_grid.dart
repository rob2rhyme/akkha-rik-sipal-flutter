// lib/features/common/widgets/unit_grid.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

class UnitGrid extends StatelessWidget {
  /// List of AkkhaUnit objects (with .transliteration and .character).
  final List<AkkhaUnit> units;

  /// Key for preserving scroll position.
  final PageStorageKey storageKey;

  const UnitGrid({Key? key, required this.units, required this.storageKey})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // A. Style used to render the actual Unicode Akkha glyph in your custom font:
    const akkhaStyle = TextStyle(
      fontFamily: 'GurbachhanAkkhaLipi',
      fontSize: 48,
    );

    // B. Style for the Roman transliteration (Latin):
    final romanStyle = Theme.of(context).textTheme.bodyMedium!;

    // C. Style for the Hindi (standard Unicode fallback) in gray:
    final fallbackStyle = Theme.of(
      context,
    ).textTheme.bodySmall!.copyWith(color: Colors.grey);

    return GridView.builder(
      key: storageKey,
      padding: const EdgeInsets.all(16),
      itemCount: units.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // three cards per row
        mainAxisSpacing: 16, // vertical spacing between cards
        crossAxisSpacing: 16, // horizontal spacing
        childAspectRatio: 0.65, // slightly taller cards
      ),
      itemBuilder: (context, index) {
        final unit = units[index];

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
                // 1️⃣ Render the real Unicode Akkha glyph (scaled down if needed):
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(unit.character, style: akkhaStyle),
                  ),
                ),

                const SizedBox(height: 6),

                // 2️⃣ Roman transliteration (e.g. “ka”, “kha”)
                Text(unit.transliteration, style: romanStyle),

                const SizedBox(height: 4),

                // 3️⃣ Hindi transliteration / standard Unicode text (in gray)
                Text(unit.hindiTransliteration, style: fallbackStyle),
              ],
            ),
          ),
        );
      },
    );
  }
}
