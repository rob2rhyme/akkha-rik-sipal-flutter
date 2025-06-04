// lib/features/learn/presentation/vowel_section.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'package:akkha_rik_lipi_sipal/features/common/widgets/unit_grid.dart';

class VowelSection extends StatefulWidget {
  final List<AkkhaUnit> indUnits; // independent vowels
  final List<AkkhaUnit> depUnits; // dependent vowels (matras)
  final List<AkkhaUnit> symUnits; // vowel symbols (anusvara, visarga, etc.)

  const VowelSection({
    super.key,
    required this.indUnits,
    required this.depUnits,
    required this.symUnits,
  });

  @override
  State<VowelSection> createState() => _VowelSectionState();
}

class _VowelSectionState extends State<VowelSection>
    with AutomaticKeepAliveClientMixin<VowelSection> {
  @override
  bool get wantKeepAlive => true;

  static const _filters = ['All', 'Independent', 'Dependent', 'Symbols'];
  String _selected = 'All';

  List<AkkhaUnit> get _filteredUnits {
    switch (_selected) {
      case 'Independent':
        return widget.indUnits;
      case 'Dependent':
        return widget.depUnits;
      case 'Symbols':
        return widget.symUnits;
      default:
        // combine all three categories in one big list
        return [...widget.indUnits, ...widget.depUnits, ...widget.symUnits];
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // ChoiceChips for vowel categories
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

        // The grid of vowels
        Expanded(
          child: UnitGrid(
            units: _filteredUnits,
            storageKey: const PageStorageKey('vowelGrid'),
          ),
        ),
      ],
    );
  }
}
