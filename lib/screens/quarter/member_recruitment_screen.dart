import 'package:flutter/material.dart';

class MemberRecruitmentScreen extends StatelessWidget {
  const MemberRecruitmentScreen({super.key});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child:  Scaffold(
        appBar: AppBar(
          title: const Text('신규 멤버 영입'),
        ),
        body: const Center(
          child: Text('신규 멤버 영입 화면'),
        ),
      ),
    );
  }
}
