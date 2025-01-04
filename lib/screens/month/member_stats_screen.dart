import 'package:flutter/material.dart';

class MemberStatsScreen extends StatelessWidget {
  const MemberStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child: Scaffold(
        appBar: AppBar(
          title: const Text('멤버 스탯'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // 레벨업 로직 추가 예정
            },
            child: const Text('레벨업하기'),
          ),
        ),
      ),
    );
  }
}
