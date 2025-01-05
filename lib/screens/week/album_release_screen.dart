import 'package:flutter/material.dart';
import '../../game_manager.dart';
import '../../logic/monthly_data_manager.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';
import '../../logic/album_logic.dart';

class AlbumReleaseScreen extends StatelessWidget {
  final TextEditingController albumNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bandProvider = Provider.of<BandProvider>(context, listen: false);
    final fanBoost=AlbumLogic.calculateFanBoost(bandProvider);
    final monthlyIncome = AlbumLogic.calculateMonthlyIncome(bandProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('음반 발매'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('음반의 이름을 지어주세요:', style: TextStyle(fontSize: 20)),
            TextField(
              controller: albumNameController,
              decoration: const InputDecoration(
                hintText: '음반 이름을 입력하세요',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final albumName = albumNameController.text;
                if (albumName.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('음반 "$albumName"이 발매되었습니다!')),
                  );
                  bandProvider.addAlbum(albumName, fanBoost, monthlyIncome);
                  bandProvider.resetAlbumWorkWeeks();
                  _onActivityComplete(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('음반 이름을 입력해주세요.')),
                  );
                }
              },
              child: const Text('발매하기'),
            ),
          ],
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
