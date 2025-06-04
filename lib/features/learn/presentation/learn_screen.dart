// lib/features/learn/presentation/learn_screen.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/akkha_unit.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/data/sectional_akkha_unit_data_source.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/presentation/consonant_section.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/presentation/vowel_section.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/presentation/number_section.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/presentation/punctuation_section.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/presentation/ten_khari_tab.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen>
    with SingleTickerProviderStateMixin {
  final _ds = SectionalAkkhaUnitDataSource();
  late final TabController _tabController;

  // Futures to load data from the data source:
  late final Future<List<AkkhaUnit>> _consonantsFuture;
  late final Future<List<List<AkkhaUnit>>> _vowelsFuture;
  late final Future<List<AkkhaUnit>> _numbersFuture;
  late final Future<List<AkkhaUnit>> _punctuationFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    // Kick off loading from your JSON or DB:
    _consonantsFuture = _ds.loadConsonants();
    _vowelsFuture = Future.wait([
      _ds.loadVowels(), // independent vowels
      _ds.loadMatras(), // dependent vowels (matra)
      _ds.loadSymbols(), // vowel symbols (e.g. visarga, anusvara)
    ]);
    _numbersFuture = _ds.loadNumbers();
    _punctuationFuture = _ds.loadPunctuation();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static const _tabIcons = [
    Icons.text_fields,
    Icons.audiotrack,
    Icons.format_list_numbered,
    Icons.more_horiz,
    Icons.grid_view,
  ];
  static const _tabLabels = [
    'Consonants',
    'Vowels',
    'Numbers',
    'Punctuation',
    '10Khari',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Akkha Rik Lipi'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabIcons.map((icon) => Tab(icon: Icon(icon))).toList(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Animated section title (updates as you switch tabs)
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

            // The TabBarView: each child corresponds to a section
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // 1️⃣ Consonants Section
                  FutureBuilder<List<AkkhaUnit>>(
                    future: _consonantsFuture,
                    builder: (ctx, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ConsonantSection(
                        units: snap.data ?? <AkkhaUnit>[],
                      );
                    },
                  ),

                  // 2️⃣ Vowels Section
                  FutureBuilder<List<List<AkkhaUnit>>>(
                    future: _vowelsFuture,
                    builder: (ctx, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final lists =
                          snap.data ??
                          [<AkkhaUnit>[], <AkkhaUnit>[], <AkkhaUnit>[]];
                      return VowelSection(
                        indUnits: lists[0],
                        depUnits: lists[1],
                        symUnits: lists[2],
                      );
                    },
                  ),

                  // 3️⃣ Numbers Section
                  FutureBuilder<List<AkkhaUnit>>(
                    future: _numbersFuture,
                    builder: (ctx, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return NumberSection(units: snap.data ?? <AkkhaUnit>[]);
                    },
                  ),

                  // 4️⃣ Punctuation Section
                  FutureBuilder<List<AkkhaUnit>>(
                    future: _punctuationFuture,
                    builder: (ctx, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return PunctuationSection(
                        units: snap.data ?? <AkkhaUnit>[],
                      );
                    },
                  ),

                  // 5️⃣ 10Khari Tab (standard Unicode Devanagari)
                  const TenKhariTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
