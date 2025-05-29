// lib/features/common/widgets/unit_grid.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

class UnitGrid extends StatelessWidget {
  final List<AkkhaUnit> units;
  final PageStorageKey storageKey;

  const UnitGrid({super.key, required this.units, required this.storageKey});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    final defaultStyle = DefaultTextStyle.of(context).style;

    // Reduce the Akkha character size for smaller screens:
    final charStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontSize: 25,
    ); // was using default headlineSmall

    final translitStyle = defaultStyle.copyWith(fontSize: 14);
    final hindiStyle = defaultStyle.copyWith(fontSize: 18, color: Colors.grey);

    return Padding(
      padding: EdgeInsets.fromLTRB(12, 12, 12, 12 + bottomInset),
      child: GridView.builder(
        key: storageKey,
        itemCount: units.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.60,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, i) {
          final u = units[i];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1) Flexible + FittedBox for the Akkha character
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          u.character,
                          style: charStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // 2) Flexible for the transliteration
                    Flexible(
                      child: Text(
                        u.transliteration,
                        style: translitStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // 3) Flexible for the Hindi transliteration
                    Flexible(
                      child: Text(
                        u.hindiTransliteration,
                        style: hindiStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
