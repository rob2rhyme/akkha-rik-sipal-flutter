// lib/features/common/widgets/dus_khari_grid.dart

import 'package:flutter/material.dart';
import '../models/dus_khari_row.dart';

class DusKhariGrid extends StatelessWidget {
  final List<DusKhariRow> rows;

  const DusKhariGrid({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // single column
        childAspectRatio: 0.75, // taller cards: width ÷ height = .75
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
                    Text(
                      row.baseUnit.character,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(row.baseUnit.transliteration),
                        Text(
                          row.baseUnit.hindiTransliteration,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // The nine syllable chips, each with its own transliterations
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: row.syllableUnits.map((u) {
                    return Chip(
                      label: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(u.character),
                          Text(
                            u.transliteration,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            u.hindiTransliteration,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
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
