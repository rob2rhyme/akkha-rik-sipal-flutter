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
        crossAxisCount: 1, // ◀️ one card per row now
        childAspectRatio: 0.75, // keep your tall card ratio
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
                // Base character
                Text(
                  row.baseChar,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 8),

                // The nine syllable chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: row.syllables
                      .map((s) => Chip(label: Text(s)))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
