import 'package:flutter/material.dart';

class GameStartScreen extends StatelessWidget {
  const GameStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game Start'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusBar(), // 돈과 팬 수를 표시하는 상단 바
          _buildButtons(context), // 처음부터/계속하기 버튼
          // ElevatedButton(
          // onPressed: () => Navigator.pushNamed(context, '/monthly-cycle'),
          // child: const Text('게임 시작'),
          // ),
        ],
       ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('돈: \$0', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('팬: 0명', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/band-name'); // 게임 시작 로직
            },
            child: const Text('처음부터'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // 저장된 데이터가 있을 경우 이어서 진행
              Navigator.pushNamed(context, '/continue-game'); // 계속하기 로직
            },
            child: const Text('계속하기'),
          ),
        ],
      ),
    );
  }
}
