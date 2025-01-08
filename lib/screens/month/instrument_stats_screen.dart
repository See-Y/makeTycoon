import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/instrument_enhance_data.dart';
import '../../models/instrument.dart';
import '../../providers/band_provider.dart';

class InstrumentStatsScreen extends StatelessWidget {
  const InstrumentStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bandProvider = Provider.of<BandProvider>(context);
    final band = bandProvider.band;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(25.0),
          child: AppBar(
            title: const Text('악기 업그레이드 하기'),
            automaticallyImplyLeading: false,
          ),
        ),
        body: PageView.builder(
          controller: PageController(viewportFraction: 0.5),
          scrollDirection: Axis.vertical, // 스크롤 방향을 세로로 변경
          itemCount: band.members.length,
          itemBuilder: (context, index) {
            final member = band.members[index];
            final instrument = member.instrument;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  //padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "악기: ${instrument.name}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("멤버: ${member.name}"),
                      Text("희귀도: ${instrument.rarity}"),
                      Text("공연 효과: ${instrument.effects['performanceBoost']!*100}%"),
                      Text("음반 효과: ${instrument.effects['albumQualityBoost']!*100}%"),
                      const SizedBox(height: 16),
                      _buildCustomButton(context, '중고 거래 등록\n${instrumentEnhanceCosts[instrument.rarity]}만 원', () {
                          final message = bandProvider.enhanceInstrument(member, instrument);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget _buildCustomButton(BuildContext context, String label, VoidCallback onPressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4, // 화면의 3/4 너비
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
              textAlign: TextAlign.center,
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
