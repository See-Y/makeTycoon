import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import '../../game_manager.dart';
import '../../logic/monthly_data_manager.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';

class WeekAlbumScreen extends StatelessWidget {
  const WeekAlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bandProvider = Provider.of<BandProvider>(context, listen: false);
    final isAlbumReleaseWeek = bandProvider.albumWorkWeeks + 1 == 5;

    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${GameManager().currentWeek}주차: 음반'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/gifs/음반작업.gif', // 기본 이미지 경로
                  width: MediaQuery.of(context).size.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 60),  // 이미지와 텍스트 사이의 간격
              Text(
                '우리 밴드는 음악 작업 중...',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'DungGeunMo'),
              ),
              SizedBox(height: 60),  // 텍스트와 버튼 사이의 간격
              _buildCustomButton(context, '다음', () {
                bandProvider.incrementAlbumWorkWeeks();
                if(isAlbumReleaseWeek){
                  _saveAlbumWorkData(context, bandProvider.albumWorkWeeks);
                  Navigator.pushNamed(context, '/album-release');
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('음반 작업을 진행했습니다. (${bandProvider.albumWorkWeeks}/5)')),
                  );
                  _onActivityComplete(context);
                }
              }),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _saveAlbumWorkData(BuildContext context, int workingWeek) {
    final gameManager = GameManager();
    MonthlyDataManager().setWeeklyActivity(
      gameManager.currentWeek - 1,
      WeeklyActivity(
        activityType: "음반 작업",
        venue: null,
        ticketPrice: null,
        audienceCount: null,
        fanChange: null,
        revenue: null,
        success: null,
        albumWeek: workingWeek,
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
    final nextWeekActivity = manager.getWeeklyActivity(GameManager().currentWeek - 1)?.activityType;

    if (nextWeekActivity == "공연") {
      Navigator.pushNamed(context, '/week-performance');
    } else if (nextWeekActivity == "음반 작업") {
      Navigator.pushNamed(context, '/week-album');
    } else if (nextWeekActivity == "휴식") {
      Navigator.pushNamed(context, '/week-rest');
    }
  }

  Widget _buildCustomButton(BuildContext context, String label, VoidCallback onPressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75, // 화면의 3/4 너비
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
