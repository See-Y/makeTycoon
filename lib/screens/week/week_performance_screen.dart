import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import '../../game_manager.dart';
import '../../logic/monthly_data_manager.dart';

class WeekPerformanceScreen extends StatelessWidget {
  const WeekPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${GameManager().currentMonth}주차: 공연'),
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
      Navigator.pushNamed(context, '/monthly-summary');
    }
  }

  void _navigateToNextWeek(BuildContext context) {
    final manager = MonthlyDataManager();
    final nextWeekActivity = manager.getWeeklyActivity(GameManager().currentWeek - 1);
    if (nextWeekActivity == "공연") {
      Navigator.pushNamed(context, '/week-performance');
    } else if (nextWeekActivity == "음반 작업") {
      Navigator.pushNamed(context, '/week-album');
    } else if (nextWeekActivity == "휴식") {
      Navigator.pushNamed(context, '/week-rest');
    }
  }
}
