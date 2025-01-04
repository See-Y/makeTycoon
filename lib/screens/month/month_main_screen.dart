import 'package:flutter/material.dart';
import 'member_stats_screen.dart';
import 'instrument_stats_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/band.dart';
import '../../providers/band_provider.dart'; // band_provider import

class MonthMainScreen extends StatelessWidget {
  const MonthMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Band bandModel = Provider.of<BandProvider>(context).band;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('돈: \$${bandModel.money} 팬: ${bandModel.fans}명'),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: PageView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '월간 사이클 메인 화면',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/schedule-input'); // 스케줄 입력 화면으로 이동
                },
                child: const Text('스케줄 입력하기'),
              ),
            ],
          ),
          const MemberStatsScreen(), //왼쪽 스와이프
          const InstrumentStatsScreen(), //오른쪽 스와이프
        ],
      ),
    );
  }
}
