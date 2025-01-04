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
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/monthly-cycle'),
            child: const Text('게임 시작'),
          ),
        ),
      ),
    );
  }
}
