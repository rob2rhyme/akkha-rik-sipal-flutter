// lib/features/learn/presentation/ten_khari_tab.dart

import 'package:flutter/material.dart';
import '../../common/models/dus_khari_row.dart';
import '../data/dush_khari_data_source.dart';
import '../../common/widgets/dus_khari_grid.dart';

class TenKhariTab extends StatefulWidget {
  const TenKhariTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TenKhariTabState createState() => _TenKhariTabState();
}

class _TenKhariTabState extends State<TenKhariTab>
    with AutomaticKeepAliveClientMixin<TenKhariTab> {
  late final Future<List<DusKhariRow>> _future;

  @override
  void initState() {
    super.initState();
    _future = DusKhariDataSource().loadDusKhari();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // must call when using AutomaticKeepAliveClientMixin
    return FutureBuilder<List<DusKhariRow>>(
      future: _future,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Failed to load 10Khari:\n${snap.error}'));
        }
        final rows = snap.data!;
        return DusKhariGrid(rows: rows);
      },
    );
  }
}
