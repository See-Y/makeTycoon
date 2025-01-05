import 'package:flutter/material.dart';
import '../../game_manager.dart';
import '../../logic/monthly_data_manager.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';

class AlbumReleaseScreen extends StatelessWidget {
  final TextEditingController albumNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bandProvider = Provider.of<BandProvider>(context, listen: false);
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
                  //bandProvider.addAlbum(albumName, calculateAlbumFanBoost(stats, baseIncome, fanBoost), calculateAlbumIncome(stats, baseIncome, fanBoost))
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

  int calculateAlbumIncome(List<double> stats, int baseIncome, int fanBoost) {
    double quirkinessBonus = stats[1]* 0.03; // 똘끼의 3% 만큼 고정 수익 증가
    double gutsBonus = stats[2] * 0.02; // 깡의 2% 만큼 고정 수익 증가
    double coolnessBonus = stats[3] * 0.01; // 스껄의 1% 만큼 수익 안정성 증가

    double finalIncome = baseIncome * (1 + quirkinessBonus + gutsBonus + coolnessBonus);

    return finalIncome.toInt();
  }

  int calculateAlbumFanBoost(List<double> stats, int baseIncome, int fanBoost) {
    double charismaBonus = stats[0] * 0.05; // 관종의 5% 만큼 팬 증가량 증가
    double finalFanBoost = fanBoost * (1 + charismaBonus);

    return finalFanBoost.toInt();
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
