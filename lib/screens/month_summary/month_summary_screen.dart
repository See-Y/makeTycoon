import 'package:flutter/material.dart';
import '../../client/user_data_send.dart';
import '../../game_manager.dart';
import '../../logic/monthly_data_manager.dart';
import '../../widget/global_wrapper.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';
import '../../models/band.dart';

class MonthSummaryScreen extends StatelessWidget {
  const MonthSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameManager = GameManager();
    BandProvider bandProvider = Provider.of<BandProvider>(context);
    Band band = bandProvider.band;
    final monthlyActivities = MonthlyDataManager().weeklyActivities;

    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('월간 결산'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '이번 달 결산 결과',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                '앨범으로 인한 결과',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    '고정 수입: ${band.albums.fold(0, (sum, album) => sum + album.monthlyIncome)}만 원',
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    '앨범으로 증가한 총 팬 수: ${band.albums.fold(0, (sum, album) => sum + album.fanBoost)}명',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '주차별 활동 요약',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: monthlyActivities.length,
                  itemBuilder: (context, index) {
                    final activity = monthlyActivities[index];
                    if (activity == null) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListTile(
                          title: Text(
                            "제 ${index + 1} 주차: 활동 없음",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }

                    if (activity.activityType == "앨범 출시") {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListTile(
                          title: Text(
                            "제 ${index + 1} 주차: ${activity.activityType}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "앨범 이름: ${activity.albumName ?? ''}\n"
                                "${activity.fanChange != null ? '팬 증가: ${activity.fanChange!.toInt()}명\n' : ''}"
                                "${activity.revenue != null ? '고정수익: ${activity.revenue!.toInt()}만 원' : ''}",
                          ),
                        ),
                      );
                    }

                    if (activity.activityType == "공연") {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListTile(
                          title: Text(
                            "제 ${index + 1} 주차: ${activity.activityType}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "공연장: ${activity.venue?.name ?? ''}\n"
                                "티켓 가격: ${activity.ticketPrice?.toInt()}원\n"
                                "관객 수: ${activity.audienceCount ?? 0}명\n"
                                "팬 수 변화: ${activity.fanChange ?? 0}명\n"
                                "수익: ${activity.revenue?.toInt()}만 원\n"
                                "성공 여부: ${activity.success != null && activity.success! >= 1.0 ? '성공' : '실패'}",
                          ),
                        ),
                      );
                    }

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ListTile(
                        title: Text(
                          "제 ${index + 1} 주차: ${activity.activityType}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: _buildCustomButton(context, '다음', () {
                  bandProvider.applyMonthlySummary();
                  MonthlyDataManager().resetMonthlyData();
                  if (gameManager.isQuarterStart()) {
                    Navigator.pushNamed(context, '/quarter-main');
                  } else {
                    Navigator.pushReplacementNamed(context, '/monthly-cycle');
                  }
                }),
              ),
              const SizedBox(height: 20),
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
                fontSize: 20,          // 폰트 크기
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
