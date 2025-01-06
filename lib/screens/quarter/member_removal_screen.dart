import 'package:flutter/material.dart';
import 'package:make_tycoon/widget/global_wrapper.dart';

class MemberRemovalScreen extends StatelessWidget {
  const MemberRemovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('멤버 탈퇴'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: const Center(
          child: Text('멤버 탈퇴 화면'),
        ),
      );
  }
}
