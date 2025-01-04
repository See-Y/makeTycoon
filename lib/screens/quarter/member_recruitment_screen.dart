import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';

class MemberRecruitmentScreen extends StatelessWidget {
  const MemberRecruitmentScreen({super.key});

  @override
  Widget build(BuildContext context) {return GlobalWrapper(
      child:  Scaffold(
        appBar: AppBar(
          title: const Text('신규 멤버 영입'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: const Center(
          child: Text('신규 멤버 영입 화면'),
        ),
      ),
    );
  }
}
