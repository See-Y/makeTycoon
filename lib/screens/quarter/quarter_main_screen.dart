import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';
import 'member_removal_screen.dart';
import 'member_recruitment_screen.dart';

class QuarterMainScreen extends StatelessWidget {
  const QuarterMainScreen({super.key});

  @override
  Widget build(BuildContext context) {return GlobalWrapper(
      child: Scaffold(
        body: PageView(
          children: [
            _QuarterCycleMain(onNext: () {
              Navigator.pushNamed(context, '/monthly-cycle');
            }),
            const MemberRemovalScreen(),
            const MemberRecruitmentScreen(),
          ],
        ),
      ),
    );
  }
}

class _QuarterCycleMain extends StatelessWidget {
  final VoidCallback onNext;

  const _QuarterCycleMain({required this.onNext});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child: Scaffold(
        appBar: AppBar(
          title: const Text('분기 사이클 메인'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: onNext,
            child: const Text('다음'),
          ),
        ),
      ),
    );
  }
}
