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
        appBar: AppBar(
          title: const Text('악기 스탯'),
          automaticallyImplyLeading: false,
        ),
        body: PageView.builder(
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "멤버: ${member.name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("악기: ${instrument.name}"),
                      Text("희귀도: ${instrument.rarity}"),
                      Text("공연 효과: ${instrument.effects['performanceBoost']}"),
                      Text("음반 효과: ${instrument.effects['albumQualityBoost']}"),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final message = bandProvider.enhanceInstrument(member, instrument);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );
                        },
                        child: Text("강화하기 : ${instrumentEnhanceCosts[instrument.rarity]}만 원"),
                      ),
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
}
