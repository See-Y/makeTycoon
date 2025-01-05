import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import '../../game_manager.dart';
import '../../logic/monthly_data_manager.dart';
import '../../data/venue_data.dart';
import '../../models/venue.dart';

class WeekPerformanceScreen extends StatefulWidget {
  const WeekPerformanceScreen({super.key});

  @override
  State<WeekPerformanceScreen> createState() => _WeekPerformanceScreenState();
}

class _WeekPerformanceScreenState extends State<WeekPerformanceScreen> {

  int ticketPrice = 0; // 티켓 가격 저장 변수

  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${GameManager().currentMonth}주차: 공연'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: venueData.length,
            itemBuilder: (context, index) {
              final Venue venue = venueData[index];
              return Card(
                elevation: 4, // 그림자 효과
                margin: const EdgeInsets.symmetric(vertical: 8.0), // 카드 간 간격
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venue.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text("대관료: ${venue.fee}원"),
                            Text("팬 증가: +${venue.fanIncrease}명"),
                            TextField(
                              decoration: const InputDecoration(labelText: '티켓 가격 입력'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                ticketPrice = int.tryParse(value) ?? 0;
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // 버튼 색상
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/week-performance-result',
                              arguments: {'venue': venue, 'ticketPrice': ticketPrice}); //공연 결과 화면으로 이동!!
                        },
                        child: const Text(
                          '선택하기',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
