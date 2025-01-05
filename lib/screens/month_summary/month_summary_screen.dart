import 'package:flutter/material.dart';
import '../../game_manager.dart';
import '../../widget/global_wrapper.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';
import '../../models/band.dart';

class MonthSummaryScreen extends StatelessWidget {
  const MonthSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameManager = GameManager();
    BandProvider bandProvider=Provider.of<BandProvider>(context);
    Band band=bandProvider.band;
    return GlobalWrapper(
        child:  Scaffold(
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
              Text('총 수입: ${band.albums.fold(0, (sum, album) => sum + album.monthlyIncome)}만 원'),
              Text('새로운 팬 수: ${band.albums.fold(0, (sum, album) => sum + album.fanBoost)}명'),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  bandProvider.applyMonthlySummary();
                  if (gameManager.isQuarterStart()) {
                  // 분기 시작 시 분기 화면으로 이동
                    Navigator.pushNamed(context, '/quarter-main');
                  } else {
                  // 그렇지 않으면 월간 사이클로 돌아감
                    Navigator.pushReplacementNamed(context, '/monthly-cycle');
                  }
                },
                child: const Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
