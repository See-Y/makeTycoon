import 'package:flutter/material.dart';
import 'package:make_tycoon/screens/month/album_list_screen.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import 'member_stats_screen.dart';
import 'instrument_stats_screen.dart';
import '../../logic/monthly_data_manager.dart';
import '../../game_manager.dart';

import 'package:provider/provider.dart';
import '../../models/band.dart';
import '../../models/member.dart';
import '../../providers/band_provider.dart'; // band_provider import


class MonthMainScreen extends StatelessWidget {
  const MonthMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Band bandModel = Provider.of<BandProvider>(context).band;
    final currentMonth = GameManager().currentMonth; // 현재 달 정보 가져오기

    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${currentMonth}월"),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: PageView(
          controller: PageController(initialPage: 2),  // 시작 페이지를 2로 설정
          children: [
            AlbumListScreen(),
            MemberStatsScreen(),  // 왼쪽으로 스와이프하면 악기 스탯 화면
            _MonthCycleMain(),
            InstrumentStatsScreen(),  // 오른쪽으로 스와이프하면 멤버 스탯 화면
          ],
        ),
      ),
    );
  }
}

class _MonthCycleMain extends StatefulWidget {
  const _MonthCycleMain();

  @override
  State<_MonthCycleMain> createState() => _MonthCycleMainState();
}

class _MonthCycleMainState extends State<_MonthCycleMain> {
  final List<String> activityOptions = ["공연", "음반 작업", "휴식"];

  void _startWeeklyCycle(BuildContext context) {
    final manager = MonthlyDataManager();

    if (!manager.isAllWeeksSelected()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("모든 주차의 활동을 선택해주세요.")),
      );
      return;
    }

    _navigateToWeekScreen(context);
  }

  void _navigateToWeekScreen(BuildContext context) {
    final manager = MonthlyDataManager();
    final week = GameManager().currentWeek;
    final activity = manager.getWeeklyActivity(week - 1)?.activityType; // 주차는 0부터 저장

    // 현재 주차의 활동에 따라 이동
    if (activity == "공연") {
      Navigator.pushNamed(context, '/week-performance');
    } else if (activity == "음반 작업") {
      Navigator.pushNamed(context, '/week-album');
    } else if (activity == "휴식") {
      Navigator.pushNamed(context, '/week-rest');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Band bandModel = Provider.of<BandProvider>(context).band;
    final currentMonth = GameManager().currentMonth; // 현재 달 정보 가져오기
    List<Member> sortedMembers = List.from(bandModel.members)..sort((a, b) => b.position![2].compareTo(a.position![2]));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 2.3,
              child: Stack(
                children: sortedMembers  // elevation 기준 정렬
                .map((member) {
                  return Align(
                    alignment: Alignment(member.position![0], member.position![1]),  // Alignment 기반 위치
                    child: Image.asset(
                      member.image ?? 'assets/images/갈매기.png',
                      width: MediaQuery.of(context).size.width * 0.3,  // 크기를 화면 비율에 맞춤
                    ),
                  );
                }).toList(),
              ),
          ),
          //const SizedBox(height: 16),
          const Text(
            "이번 달 계획 작성",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${index + 1}주차 활동: ${MonthlyDataManager().getWeeklyActivity(index)?.activityType ?? "선택 안됨"}"),
                  trailing: DropdownButton<String>(
                    hint: const Text("활동 선택"),
                    value: activityOptions.contains(MonthlyDataManager().getWeeklyActivity(index)?.activityType)
                        ? MonthlyDataManager().getWeeklyActivity(index)?.activityType
                        : null,
                    items: activityOptions.map((activity) {
                      return DropdownMenuItem(
                        value: activity,
                        child: Text(activity),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          MonthlyDataManager().setWeeklyActivity(index, WeeklyActivity(activityType: value));
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          _buildCustomButton(context, '다음', () {
            _startWeeklyCycle(context);
          }),
          const SizedBox(height: 30),
        ],
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
