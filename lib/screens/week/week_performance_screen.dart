import 'dart:math';

import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import '../../game_manager.dart';
import '../../data/venue_data.dart';
import '../../models/band.dart';
import '../../models/venue.dart';
import '../../logic/monthly_data_manager.dart';
import '../../logic/performance_logic.dart';
import '../../providers/band_provider.dart';
import 'package:provider/provider.dart';


class WeekPerformanceScreen extends StatefulWidget {
  const WeekPerformanceScreen({super.key});

  @override
  State<WeekPerformanceScreen> createState() => _WeekPerformanceScreenState();
}

class _WeekPerformanceScreenState extends State<WeekPerformanceScreen> {
  late PageController _pageController;
  int selectedIndex = 0; // 현재 선택된 공연장 인덱스
  late double ticketPrice; // 슬라이더로 설정된 티켓 가격
  double ticketPriceLog = 0; // 로그 값으로 변환한 티켓 가격
  double idealPrice = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    ticketPrice = venueData[selectedIndex].idealPrice.toDouble(); // 초기값 설정

  }

  // log10를 활용해 슬라이더 값을 티켓 가격으로 변환
  double _logToPrice(double value, double min, double max) {
    value = value.clamp(0.0, 1.0); // 클램핑 추가
    return pow(10, value * (log(max) / log(10) - log(min) / log(10)) + log(min) / log(10)) as double;
  }

  // 티켓 가격을 슬라이더 값으로 변환
  double _priceToLog(double price, double min, double max) {
    price = price.clamp(min, max); // 클램핑 추가
    return (log(price) / log(10) - log(min) / log(10)) / (log(max) / log(10) - log(min) / log(10));
  }

  void _onProceed(Band band) {
    final selectedVenue = venueData[selectedIndex];

    if (band.money < selectedVenue.fee) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("대관료가 부족합니다!")),
      );
      return;
    }
    band.money -= selectedVenue.fee;

    // 알고리즘을 활용해 데이터 계산
    final audienceCount = PerformanceLogic.calculateAudienceCount(
      ticketPrice,
      band.fans,
      selectedVenue,
    );

    final successRate = PerformanceLogic.calculateSuccessRate(
      band.members,
      band.leader,
    );

    final revenue = PerformanceLogic.calculatePerformanceRevenue(
      audienceCount,
      ticketPrice,
      successRate,
      band.members,
    );

    band.money += revenue.toInt();

    final fanChange = successRate >= 1.0
        ? PerformanceLogic.calculateFanIncrease(successRate, selectedVenue, band.members, audienceCount)
        : PerformanceLogic.calculateFanDecrease(successRate, band.fans);

    band.fans += fanChange.toInt();

    // 공연 결과 데이터를 저장
    MonthlyDataManager().setWeeklyActivity(
      GameManager().currentWeek - 1,
      WeeklyActivity(
        activityType: "공연",
        venue: selectedVenue,
        ticketPrice: ticketPrice,
        audienceCount: audienceCount.toInt(),
        revenue: revenue,
        fanChange: fanChange,
        success: successRate,
      ),
    );

    // 결과 화면으로 이동
    Navigator.pushNamed(context, '/week-performance-result');
  }

  @override
  Widget build(BuildContext context) {
    final band = Provider.of<BandProvider>(context).band;
    final currentMoney = band.money;
    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${GameManager().currentWeek}주차: 공연'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: venueData.length,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                    ticketPrice = venueData[index].idealPrice.toDouble(); // 슬라이더 초기값 변경
                  });
                },
                itemBuilder: (context, index) {
                  final venue = venueData[index];
                  final idealPrice = venue.idealPrice.toDouble();
                  final minPrice = idealPrice * 0.1; // 슬라이더 최소값
                  final maxPrice = idealPrice * 10; // 슬라이더 최대값

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
                            venue.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text("대관료: ${venue.fee}만 원"),
                          Text("최대 관객 수: ${venue.maxAudience}명"),
                          const SizedBox(height: 16),
                          Text("티켓 가격: ${(ticketPrice*10000).toStringAsFixed(0)} 원"),
                          Slider(
                            value: _priceToLog(ticketPrice, minPrice, maxPrice),
                            min: 0.0,
                            max: 1.0,
                            divisions: 100,
                            label: "${(ticketPrice*10000).toStringAsFixed(0)} 원",
                            onChanged: (value) {
                              setState(() {
                                ticketPrice = _logToPrice(value, minPrice, maxPrice);
                              });
                            },
                          ),
                          ElevatedButton(
                            onPressed: () => _onProceed(band),
                            child: const Text('공연 진행'),
                          ),
                        ],
                      ),
                    ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
