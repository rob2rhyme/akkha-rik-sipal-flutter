// lib/features/learn/presentation/number_section.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'package:akkha_rik_lipi_sipal/features/common/widgets/unit_grid.dart';

/// NumberSection simply shows all number‐units in one grid,
/// using the PUA block starting at 0xE040.
class NumberSection extends StatelessWidget {
  final List<AkkhaUnit> units;

  const NumberSection({Key? key, required this.units}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnitGrid(
      units: units,
      storageKey: const PageStorageKey('numberGrid'),
      baseCode: 0xE040, // PUA block for numbers
    );
  }
}
