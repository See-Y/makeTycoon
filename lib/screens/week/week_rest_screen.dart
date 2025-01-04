import 'package:flutter/material.dart';

class WeekRestScreen extends StatelessWidget {
  const WeekRestScreen({super.key});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child: Scaffold(
        appBar: AppBar(
          title: const Text('휴식'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/monthly-summary'),
            child: const Text('다음'),
          ),
        ),
      ),
    );
  }
}
