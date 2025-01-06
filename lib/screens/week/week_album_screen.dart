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
          child: ElevatedButton(
            onPressed: () {
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
            },
            child: const Text('다음'),
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
}
