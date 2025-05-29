// lib/features/common/widgets/unit_grid.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

class UnitGrid extends StatelessWidget {
  final List<AkkhaUnit> units;
  final PageStorageKey storageKey;

  const UnitGrid({super.key, required this.units, required this.storageKey});

  @override
  Widget build(BuildContext context) {
    // default UI font (Urbanist) for transliterations:
    final defaultStyle = DefaultTextStyle.of(context).style;
    final translitStyle = defaultStyle.copyWith(fontSize: 14);
    final hindiStyle = defaultStyle.copyWith(fontSize: 12, color: Colors.grey);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        key: storageKey,
        itemCount: units.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          // ↓ lower aspectRatio ⇒ taller cells
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, i) {
          final u = units[i];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {},
              child: Padding(
                // ↓ smaller vertical padding
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Akkha character in your custom font
                    Text(
                      u.character,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 6),
                    // transliteration in default UI font
                    Text(u.transliteration, style: translitStyle),
                    const SizedBox(height: 4),
                    Text(u.hindiTransliteration, style: hindiStyle),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
