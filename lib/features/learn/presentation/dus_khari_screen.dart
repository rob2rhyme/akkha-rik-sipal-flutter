// lib/features/learn/presentation/dus_khari_screen.dart

import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/features/common/models/dus_khari_row.dart';
import 'package:akkha_rik_lipi_sipal/features/learn/data/dush_khari_data_source.dart';
import 'package:akkha_rik_lipi_sipal/features/common/widgets/dus_khari_grid.dart';

class DusKhariScreen extends StatelessWidget {
  const DusKhariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('10Khari Table')),
      body: FutureBuilder<List<DusKhariRow>>(
        future: DusKhariDataSource().loadDusKhari(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          return DusKhariGrid(rows: snap.data!);
        },
      ),
    );
  }
}
