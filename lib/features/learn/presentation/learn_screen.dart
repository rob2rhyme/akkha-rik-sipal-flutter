// lib/features/learn/presentation/learn_screen.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/data/local_akkha_unit_data_source.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final LocalAkkhaUnitDataSource _dataSource = LocalAkkhaUnitDataSource();

  // Define your tabs’ icons and labels
  final List<IconData> _tabIcons = [
    Icons.text_fields, // Consonants
    Icons.audiotrack, // Vowels
    Icons.brush, // Matras
    Icons.category, // Symbols
    Icons.more_horiz, // Punctuation
    Icons.format_list_numbered, // Numbers
  ];
  final List<String> _tabLabels = [
    'Vowels',
    'Consonants',
    'Matras',
    'Symbols',
    'Numbers',
    'Punctuation',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabIcons.length, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) {
          setState(() {
            // triggers rebuild so label updates
          });
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AkkhaUnit>>(
      future: _dataSource.loadAkkhaUnits(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        // group units by type
        final units = snapshot.data!;
        final byType = {
          AkkhaUnitType.vowel: units
              .where((u) => u.type == AkkhaUnitType.vowel)
              .toList(),
          AkkhaUnitType.consonant: units
              .where((u) => u.type == AkkhaUnitType.consonant)
              .toList(),
          AkkhaUnitType.matra: units
              .where((u) => u.type == AkkhaUnitType.matra)
              .toList(),
          AkkhaUnitType.symbol: units
              .where((u) => u.type == AkkhaUnitType.symbol)
              .toList(),
          AkkhaUnitType.number: units
              .where((u) => u.type == AkkhaUnitType.number)
              .toList(),
          AkkhaUnitType.punctuation: units
              .where((u) => u.type == AkkhaUnitType.punctuation)
              .toList(),
        };

        return Scaffold(
          appBar: AppBar(
            title: const Text('Learn Akkha Rik Lipi'),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true, // allow horizontal scroll
              tabs: _tabIcons.map((icon) => Tab(icon: Icon(icon))).toList(),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Display the currently selected tab’s name
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _tabLabels[_tabController.index],
                    // headline6 was removed; use titleLarge (or titleMedium) instead
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                // The grids
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _tabLabels.map((label) {
                      // pick the right list by matching index
                      final idx = _tabLabels.indexOf(label);
                      final type = AkkhaUnitType.values[idx];
                      final list = byType[type]!;
                      return _UnitGrid(units: list);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Reusable grid widget
class _UnitGrid extends StatelessWidget {
  final List<AkkhaUnit> units;
  const _UnitGrid({Key? key, required this.units}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (units.isEmpty) {
      return const Center(child: Text('No items in this section.'));
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: units.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, i) => _UnitCard(unit: units[i]),
      ),
    );
  }
}

class _UnitCard extends StatelessWidget {
  final AkkhaUnit unit;
  const _UnitCard({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          // TODO: play audio/animation or navigate
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
