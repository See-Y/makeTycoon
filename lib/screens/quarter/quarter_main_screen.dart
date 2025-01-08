import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import 'member_removal_screen.dart';
import 'member_recruitment_screen.dart';
import '../../game_manager.dart';

class QuarterMainScreen extends StatelessWidget {
  const QuarterMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentMonth = GameManager().currentMonth; // 현재 달 정보 가져오기
    print("main page checked");

    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
        title: Text("${currentMonth}월"),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      ),
        body: PageView(
          controller: PageController(initialPage:0),
          children: [
            //MemberRemovalScreen(),
            _QuarterCycleMain(),
            MemberRecruitmentScreen(),
          ],
        ),
      ),
    );
  }
}

class _QuarterCycleMain extends StatefulWidget {
  const _QuarterCycleMain();

  @override
  State<_QuarterCycleMain> createState() => _QuarterCycleMainState();
}

class _QuarterCycleMainState extends State<_QuarterCycleMain> {
  @override
  Widget build(BuildContext context) {
    print("main build checked");
    return Scaffold(
      appBar: AppBar(
        title: const Text('이번 달에는 새로운 멤버를\n영입할 수 있습니다!'),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("오른쪽으로 스와이프하여 새 멤버를 영입하세요"),
            const SizedBox(height: 18),
            _buildCustomButton(context, '계속하기', () {
              Navigator.pushNamed(context, '/monthly-cycle');
            }),
          ],
        ),
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
