import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import 'member_removal_screen.dart';
import 'member_recruitment_screen.dart';

class QuarterMainScreen extends StatelessWidget {
  const QuarterMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("main page checked");

    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
        title: Text("월"),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      ),
        body: PageView(
          controller: PageController(initialPage:1),
          children: [
            MemberRemovalScreen(),
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
        title: const Text('분기 사이클 메인'),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => {
            Navigator.pushNamed(context, '/monthly-cycle')
        },
        child: const Text('다음'),
      ),
    ),);
  }
}
