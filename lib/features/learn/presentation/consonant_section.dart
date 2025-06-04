// lib/features/learn/presentation/consonant_section.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'package:akkha_rik_lipi_sipal/features/common/widgets/unit_grid.dart';

class ConsonantSection extends StatefulWidget {
  final List<AkkhaUnit> units;
  const ConsonantSection({super.key, required this.units});

  @override
  State<ConsonantSection> createState() => _ConsonantSectionState();
}

class _ConsonantSectionState extends State<ConsonantSection>
    with AutomaticKeepAliveClientMixin<ConsonantSection> {
  @override
  bool get wantKeepAlive => true;

  static const _filters = [
    'All',
    'Guttural',
    'Palatal',
    'Retroflex',
    'Dental',
    'Labial',
  ];
  String _selected = 'All';

  List<AkkhaUnit> get _filteredUnits {
    if (_selected == 'All') return widget.units;
    return widget.units.where((u) => u.group == _selected).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        // ChoiceChips for filtering by group
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: _filters.map((f) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(f),
                  selected: _selected == f,
                  onSelected: (sel) => setState(() => _selected = f),
                ),
              );
            }).toList(),
          ),
        ),

        // The grid of consonants (PUA range U+E001…)
        Expanded(
          child: UnitGrid(
            units: _filteredUnits,
            storageKey: const PageStorageKey('consonantGrid'),
            baseCode: 0xE001, // PUA start for consonants
          ),
        ),
      ],
    );
  }
}
