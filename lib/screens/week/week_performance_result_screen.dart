import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../../game_manager.dart';
import '../../logic/monthly_data_manager.dart';
import '../../models/venue.dart';
import '../../providers/band_provider.dart';



class WeekPerformanceResultScreen extends StatelessWidget {
  const WeekPerformanceResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final Venue venue = args['venue'];
    final int ticketPrice = args['ticketPrice'];
    final bandProvider = Provider.of<BandProvider>(context);
    final band = bandProvider.band;
    // 팬 참여 비율을 랜덤으로 설정 (50% ~ 70%)
    final Random random = Random();
    final double fanParticipationRate = 0.5 + (random.nextDouble() * 0.2); // 0.5 ~ 0.7
    final int totalFans=band.fans;

    final int attendees = (totalFans * fanParticipationRate).toInt();
    final int income = (attendees * ticketPrice).toInt();

    final int fanIncrease = (venue.fanIncrease).toInt(); // 팬 수 증가
    bandProvider.updateFans(totalFans + fanIncrease);

    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${GameManager().currentMonth}주차: 공연 결과'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _onActivityComplete(context);
              },
              child: const Text('다음'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("선택한 공연장: ${venue.name}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text("티켓 가격: $ticketPrice원"),
                Text("총 팬 수: $totalFans명"),
                Text("공연 참여 팬 수: $attendees명 (${(fanParticipationRate * 100).toStringAsFixed(1)}%)"),
                Text("팬 증가: +$fanIncrease명"),
                Text("총 수익: $income원"),
              // 공연 결과에 따른 추가 정보 표시 가능
              ],
            ),
          ], //children
        ),
      ),
    );
  }

  int calculatePerformanceIncome(List<double> stats, int ticketPrice, int attendees) {
    double quirkinessBonus = stats[1] * 0.02; // 똘끼 수치의 2% 만큼 수익 증가
    double gutsBonus = stats[2] * 0.01; // 깡 수치의 1% 만큼 수익 증가

    double finalIncome = attendees * ticketPrice * (1 + quirkinessBonus + gutsBonus);
    return finalIncome.toInt();
  }

  int calculatePerformanceFanBoost(List<double> stats, int baseFanboost) {
    double charismaBonus = stats[0] * 0.03; // 관종 수치의 3% 만큼 팬 수 증가
    double coolnessBonus = stats[3] * 0.005; // 스껄 수치의 0.5% 만큼 팬 수 증가

    double finalIncome = baseFanboost * (1 + charismaBonus + coolnessBonus);
    return finalIncome.toInt();
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
