// lib/features/common/widgets/unit_grid.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';

/// Renders a simple List<AkkhaUnit> as a grid.
class UnitGrid extends StatelessWidget {
  final List<AkkhaUnit> units;
  final PageStorageKey storageKey;

  const UnitGrid({super.key, required this.units, required this.storageKey});

  @override
  Widget build(BuildContext context) {
    if (units.isEmpty) {
      return const Center(child: Text('No items in this section.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        key: storageKey,
        itemCount: units.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, i) => _UnitCard(unit: units[i]),
      ),
    );
  }
}

/// Helper to render a Future<List<AkkhaUnit>> into the same grid.
class FutureUnitGrid extends StatelessWidget {
  final Future<List<AkkhaUnit>> future;
  final PageStorageKey storageKey;

  const FutureUnitGrid({
    super.key,
    required this.future,
    required this.storageKey,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AkkhaUnit>>(
      future: future,
      builder: (c, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final units = snap.data ?? [];
        return UnitGrid(units: units, storageKey: storageKey);
      },
    );
  }
}

/// Internal card for a single AkkhaUnit.
class _UnitCard extends StatelessWidget {
  final AkkhaUnit unit;
  const _UnitCard({required this.unit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          // TODO: play audio / show detail
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    unit.character,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    unit.transliteration,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    unit.hindiTransliteration,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
