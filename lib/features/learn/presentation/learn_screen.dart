import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/data/sectional_akkha_unit_data_source.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/presentation/consonant_section.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/presentation/vowel_section.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen>
    with SingleTickerProviderStateMixin {
  final _ds = SectionalAkkhaUnitDataSource();

  late final TabController _tabController;

  // Cached Futures to avoid flicker
  late final Future<List<AkkhaUnit>> _consonantsFuture;
  late final Future<List<List<AkkhaUnit>>> _vowelsFuture;
  late final Future<List<AkkhaUnit>> _numbersFuture;
  late final Future<List<AkkhaUnit>> _punctuationFuture;

  final _tabIcons = [
    Icons.text_fields, // Consonants
    Icons.audiotrack, // Vowels
    Icons.format_list_numbered, // Numbers
    Icons.more_horiz, // Punctuation
  ];

  final _tabLabels = ['Consonants', 'Vowels', 'Numbers', 'Punctuation'];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabIcons.length, vsync: this);

    // Cache the futures to prevent flicker
    _consonantsFuture = _ds.loadConsonants();
    _vowelsFuture = Future.wait([
      _ds.loadVowels(),
      _ds.loadMatras(),
      _ds.loadSymbols(),
    ]);
    _numbersFuture = _ds.loadNumbers();
    _punctuationFuture = _ds.loadPunctuation();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Akkha Rik Lipi'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabIcons.map((i) => Tab(icon: Icon(i))).toList(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AnimatedBuilder(
                animation: _tabController,
                builder: (_, __) => Text(
                  _tabLabels[_tabController.index],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // 1️⃣ Consonants
                  FutureBuilder<List<AkkhaUnit>>(
                    future: _consonantsFuture,
                    builder: (c, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ConsonantSection(units: snap.data ?? []);
                    },
                  ),

                  // 2️⃣ Vowels (independent / dependent / symbols)
                  FutureBuilder<List<List<AkkhaUnit>>>(
                    future: _vowelsFuture,
                    builder: (c, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final lists = snap.data ?? [[], [], []];
                      return VowelSection(
                        indUnits: lists[0],
                        depUnits: lists[1],
                        symUnits: lists[2],
                      );
                    },
                  ),

                  // 3️⃣ Numbers
                  FutureUnitGrid(future: _numbersFuture),

                  // 4️⃣ Punctuation
                  FutureUnitGrid(future: _punctuationFuture),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders a simple List<AkkhaUnit> as a grid
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
        itemBuilder: (context, i) => _UnitCard(unit: units[i]),
      ),
    );
  }
}

/// Helper to render any Future<List<AkkhaUnit>> as the same grid
class FutureUnitGrid extends StatelessWidget {
  final Future<List<AkkhaUnit>> future;
  const FutureUnitGrid({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AkkhaUnit>>(
      future: future,
      builder: (c, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final units = snap.data ?? [];
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
            itemBuilder: (_, i) => _UnitCard(unit: units[i]),
          ),
        );
      },
    );
  }
}

/// Internal card for a single AkkhaUnit
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
