import 'package:flutter/material.dart';

class InstrumentStatsScreen extends StatelessWidget {
  const InstrumentStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false, // 뒤로가기 비활성화
        child: Scaffold(
        appBar: AppBar(
          title: const Text('악기 스탯'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // 강화 로직 추가 예정
            },
            child: const Text('강화하기'),
          ),
        ),
      ),
    );
  }
}
