import 'package:flutter/material.dart';
import '../../game_manager.dart';

class MonthSummaryScreen extends StatelessWidget {
  const MonthSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameManager = GameManager();
    return PopScope(
        canPop: false, // 뒤로가기 비활성화
        child:  Scaffold(
        appBar: AppBar(
          title: const Text('월간 결산'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              gameManager.incrementMonth();

              if (gameManager.isQuarterStart()) {
                // 분기 시작 시 분기 화면으로 이동
                Navigator.pushNamed(context, '/quarter-main');
              } else {
                // 그렇지 않으면 월간 사이클로 돌아감
                Navigator.pushNamed(context, '/monthly-cycle');
              }
            },
            child: const Text('다음'),
          ),
        ),
      ),
    );
  }
}
