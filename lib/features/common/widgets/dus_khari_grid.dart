// lib/features/common/widgets/dus_khari_grid.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/dus_khari_row.dart';

class DusKhariGrid extends StatelessWidget {
  final List<DusKhariRow> rows;
  const DusKhariGrid({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    // Grab the default text style (which uses your global 'Urbanist' font)
    final defaultStyle = DefaultTextStyle.of(context).style;
    final translitStyle = defaultStyle.copyWith(fontSize: 14);
    final hindiStyle = defaultStyle.copyWith(fontSize: 12, color: Colors.grey);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: rows.length,
      itemBuilder: (context, idx) {
        final row = rows[idx];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Base character + its transliterations
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // baseChar in Akkha font via headlineSmall
                    Text(
                      row.baseUnit.character,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // transliteration uses default (Urbanist) font
                        Text(
                          row.baseUnit.transliteration,
                          style: translitStyle,
                        ),
                        Text(
                          row.baseUnit.hindiTransliteration,
                          style: hindiStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // The nine syllable chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: row.syllableUnits.map((u) {
                    return Chip(
                      label: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // syllable character in Akkha font
                          Text(
                            u.character,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                          ),
                          // transliteration in default font
                          Text(
                            u.transliteration,
                            style: translitStyle.copyWith(fontSize: 12),
                          ),
                          Text(
                            u.hindiTransliteration,
                            style: hindiStyle.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
