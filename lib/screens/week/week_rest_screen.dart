import 'dart:developer';

import 'package:flutter/material.dart';
import '../../game_manager.dart';
import '../../logic/monthly_data_manager.dart';

class WeekRestScreen extends StatelessWidget {
  const WeekRestScreen({super.key});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child: Scaffold(
        appBar: AppBar(
          title: Text('${GameManager().currentMonth}주차: 휴식'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _onActivityComplete(context);
            },
            child: const Text('다음'),
          ),
        ),
      ),
    );
  }
  void _onActivityComplete(BuildContext context) {
    final gameManager = GameManager();

    if (gameManager.currentWeek < 4) {
      // 다음 주차로 진행
      gameManager.incrementWeek();
      _navigateToNextWeek(context);
    } else {
      // 월간 주기 종료
      gameManager.incrementWeek();
      //MonthlyDataManager().resetMonthlyData(); // 활동 데이터 초기화
      Navigator.pushReplacementNamed(context, '/monthly-summary');
    }
  }

  void _navigateToNextWeek(BuildContext context) {
    final manager = MonthlyDataManager();
    final nextWeekActivity = manager.getWeeklyActivity(GameManager().currentWeek - 1);

    if (nextWeekActivity == "공연") {
      Navigator.pushReplacementNamed(context, '/week-performance');
    } else if (nextWeekActivity == "음반 작업") {
      Navigator.pushReplacementNamed(context, '/week-album');
    } else if (nextWeekActivity == "휴식") {
      Navigator.pushReplacementNamed(context, '/week-rest');
    }
  }
}
