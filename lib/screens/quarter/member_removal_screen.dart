import 'package:flutter/material.dart';

class MemberRemovalScreen extends StatelessWidget {
  const MemberRemovalScreen({super.key});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child:  Scaffold(
        appBar: AppBar(
          title: const Text('멤버 탈퇴'),
        ),
        body: const Center(
          child: Text('멤버 탈퇴 화면'),
        ),
      ),
    );
  }
}
