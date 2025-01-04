import 'package:flutter/material.dart';
import 'member_stats_screen.dart';
import 'instrument_stats_screen.dart';

class MonthMainScreen extends StatelessWidget {
  const MonthMainScreen({super.key});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child:  Scaffold(
        body: PageView(
          children: [
            _MonthCycleMain(onNext: () {
              Navigator.pushNamed(context, '/weekly-performance');
            }),
            const MemberStatsScreen(),
            const InstrumentStatsScreen(),
          ],
        ),
      ),
    );
  }
}

class _MonthCycleMain extends StatelessWidget {
  final VoidCallback onNext;

  const _MonthCycleMain({required this.onNext});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child:  Scaffold(
        appBar: AppBar(
          title: const Text('월간 사이클 메인'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: onNext,
            child: const Text('다음'),
          ),
        ),
      ),
    );
  }
}
