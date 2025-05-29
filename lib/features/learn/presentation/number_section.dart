// lib/features/learn/presentation/number_section.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'package:akkha_rik_lipi_sipal/features/common/widgets/unit_grid.dart';

class NumberSection extends StatefulWidget {
  final List<AkkhaUnit> units;
  const NumberSection({super.key, required this.units});

  @override
  _NumberSectionState createState() => _NumberSectionState();
}

class _NumberSectionState extends State<NumberSection>
    with AutomaticKeepAliveClientMixin<NumberSection> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return UnitGrid(
      units: widget.units,
      storageKey: const PageStorageKey('numberGrid'),
    );
  }
}
