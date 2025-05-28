import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'package:akkha_rik_lipi_sipal/features/common/widgets/unit_grid.dart'; // Ensure UnitGrid is imported

class VowelSection extends StatefulWidget {
  final List<AkkhaUnit> indUnits;
  final List<AkkhaUnit> depUnits;
  final List<AkkhaUnit> symUnits;
  const VowelSection({
    Key? key,
    required this.indUnits,
    required this.depUnits,
    required this.symUnits,
  }) : super(key: key);

  @override
  _VowelSectionState createState() => _VowelSectionState();
}

class _VowelSectionState extends State<VowelSection> {
  static const _filters = ['All', 'Independent', 'Dependent', 'Symbol'];
  String _selected = 'All';

  List<AkkhaUnit> get _filteredUnits {
    switch (_selected) {
      case 'Independent':
        return widget.indUnits;
      case 'Dependent':
        return widget.depUnits;
      case 'Symbol':
        return widget.symUnits;
      case 'All':
      default:
        return [...widget.indUnits, ...widget.depUnits, ...widget.symUnits];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // filter chips
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
                  onSelected: (_) => setState(() {
                    _selected = f;
                  }),
                ),
              );
            }).toList(),
          ),
        ),
        // filtered grid
        Expanded(
          child: UnitGrid(
            units: _filteredUnits,
            storageKey: PageStorageKey('vowel_section'),
          ),
        ),
      ],
    );
  }
}
