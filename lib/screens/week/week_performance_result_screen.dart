import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import '../../logic/monthly_data_manager.dart';
import '../../game_manager.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';

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
    final bandProvider = Provider.of<BandProvider>(context, listen: false);
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

    bandProvider.updateLeaderApprovalRatings(success!>=0);



    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${GameManager().currentWeek}주차: 공연 결과'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("공연장: ${venue.name}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              success! >= 1.0 ?
              Text("공연 성공!: $success", style: const TextStyle(fontSize: 15))
                  : Text("공연 폭망...: $success", style: const TextStyle(fontSize: 15))
              ,Text("총 관객 수: $audienceCount명", style: const TextStyle(fontSize: 15)),
              fanChange! >= 0 ?
                Text("팬 증가: ${fanChange > 0 ? '+$fanChange' : '없음'}", style: const TextStyle(fontSize: 15))
                  : Text("팬 감소: $fanChange명", style: const TextStyle(fontSize: 15))

              ,Text("총 수익: ${(revenue*10000).toStringAsFixed(0)} 원", style: const TextStyle(fontSize: 15)),
              Text("티켓 가격: ${(ticketPrice*10000).toStringAsFixed(0)} 원", style: const TextStyle(fontSize: 15)),
            ],
          ),
            const SizedBox(height: 10),
            Center(
              child: _buildCustomButton(context, '다음', () {
                _onActivityComplete(context);
              }),
            ),
          ],
        ),
        ),
      ),
    );
  }
  Widget _buildCustomButton(BuildContext context, String label, VoidCallback onPressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5, // 화면의 3/4 너비
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16), // 버튼 높이
          decoration: BoxDecoration(
            color: Colors.black, // 버튼 배경 색상
            borderRadius: BorderRadius.circular(25), // 둥근 직사각형
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // 그림자 색상
                offset: Offset(0, 5), // 그림자 위치 (X, Y)
                blurRadius: 10, // 그림자 흐림 정도
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,   // 텍스트 색상
                fontSize: 15,          // 폰트 크기
                fontWeight: FontWeight.bold, // 폰트 두께
                fontFamily: 'DungGeunMo',  // 폰트 패밀리
              ),
            ),
          ),
        ),
      ),
    );
  }
}
