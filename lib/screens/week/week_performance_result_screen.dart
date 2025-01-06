import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import '../../logic/monthly_data_manager.dart';
import '../../game_manager.dart';

class WeekPerformanceResultScreen extends StatelessWidget {
  const WeekPerformanceResultScreen({super.key});

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
    final nextWeekActivity = manager.getWeeklyActivity(GameManager().currentWeek - 1)?.activityType;
    if (nextWeekActivity == "공연") {
      Navigator.pushNamed(context, '/week-performance');
    } else if (nextWeekActivity == "음반 작업") {
      Navigator.pushNamed(context, '/week-album');
    } else if (nextWeekActivity == "휴식") {
      Navigator.pushNamed(context, '/week-rest');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWeek = GameManager().currentWeek - 1;
    final weeklyActivity = MonthlyDataManager().getWeeklyActivity(currentWeek);

    if (weeklyActivity == null || weeklyActivity.activityType != "공연") {
      return const Center(child: Text("공연 정보가 없습니다."));
    }

    final venue = weeklyActivity.venue!;
    final ticketPrice = weeklyActivity.ticketPrice!;
    final audienceCount = weeklyActivity.audienceCount!;
    final fanChange = weeklyActivity.fanChange;
    final revenue = weeklyActivity.revenue!;
    final success = weeklyActivity.success;

    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${GameManager().currentWeek}주차: 공연 결과'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("공연장: ${venue.name}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              success! >= 1.0 ?
              Text("공연 성공!: $success")
                  : Text("공연 폭망...: $success")
              ,Text("총 관객 수: $audienceCount명"),
              fanChange! >= 0 ?
                Text("팬 증가: ${fanChange > 0 ? '+$fanChange' : '없음'}")
                  : Text("팬 감소: $fanChange명")

              ,Text("총 수익: ${(revenue*10000).toStringAsFixed(0)} 원"),
              Text("티켓 가격: ${(ticketPrice*10000).toStringAsFixed(0)} 원"),
            ],
          ),
            ElevatedButton(
              onPressed: () {
                _onActivityComplete(context);
              },
              child: const Text('다음'),
            )
          ]
        ),
      ),
    );
  }
}
