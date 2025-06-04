// lib/features/learn/presentation/punctuation_section.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'package:akkha_rik_lipi_sipal/features/common/widgets/unit_grid.dart';

class PunctuationSection extends StatefulWidget {
  final List<AkkhaUnit> units;
  const PunctuationSection({super.key, required this.units});

  @override
  State<PunctuationSection> createState() => _PunctuationSectionState();
}

class _PunctuationSectionState extends State<PunctuationSection>
    with AutomaticKeepAliveClientMixin<PunctuationSection> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return UnitGrid(
      units: widget.units,
      storageKey: const PageStorageKey('punctuationGrid'),
      baseCode: 0xE050, // PUA start for punctuation
    );
  }
}
