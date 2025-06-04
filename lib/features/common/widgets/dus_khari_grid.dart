// lib/features/common/widgets/dus_khari_grid.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/dus_khari_row.dart';

/// Displays the full list of 10-Khari rows as self-sizing cards.
class DusKhariGrid extends StatelessWidget {
  final List<DusKhariRow> rows;

  const DusKhariGrid({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: rows.length,
      itemBuilder: (context, index) {
        // 1️⃣ Give each row card a minimum height
        return SizedBox(
          height: 470, // ← increase or decrease as needed
          child: _DusKhariRowCard(row: rows[index]),
        );
      },
    );
  }
}

/// A single 10-Khari row card: base consonant + its 9 vowel-forms.
class _DusKhariRowCard extends StatelessWidget {
  final DusKhariRow row;
  const _DusKhariRowCard({required this.row});

  @override
  Widget build(BuildContext context) {
    final defaultStyle = DefaultTextStyle.of(context).style;
    final translitStyle = defaultStyle.copyWith(fontSize: 14);
    final hindiStyle = defaultStyle.copyWith(fontSize: 12, color: Colors.grey);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Base consonant + labels ───
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
                    Text(row.baseUnit.transliteration, style: translitStyle),
                    Text(row.baseUnit.hindiTransliteration, style: hindiStyle),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12), // extra breathing room
            // ─── Inner 5-column grid of syllables ───
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8, // a bit more vertical gap
                crossAxisSpacing: 8, // a bit more horizontal gap
                childAspectRatio: 0.7, // ← taller boxes (height > width)
              ),
              itemCount: row.syllableUnits.length,
              itemBuilder: (context, i) {
                final u = row.syllableUnits[i];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      /* play audio… */
                    },
                    child: Padding(
                      // 3️⃣ Increase vertical padding inside child
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16, // ↑ was 12
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            u.character,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            u.transliteration,
                            style: translitStyle.copyWith(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            u.hindiTransliteration,
                            style: hindiStyle.copyWith(fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
