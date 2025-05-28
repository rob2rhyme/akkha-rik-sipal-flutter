// lib/features/learn/presentation/consonant_section.dart
import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'learn_screen.dart'; // for UnitGrid

class ConsonantSection extends StatefulWidget {
  final List<AkkhaUnit> units;
  const ConsonantSection({Key? key, required this.units}) : super(key: key);

  @override
  _ConsonantSectionState createState() => _ConsonantSectionState();
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
    super.build(context); // ← important when using KeepAlive mixin
    return Column(
      children: [
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
        Expanded(
          child: UnitGrid(
            units: _filteredUnits,
            storageKey: const PageStorageKey('consonantGrid'),
          ),
        ),
      ],
    );
  }
}
