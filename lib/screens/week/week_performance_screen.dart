import 'package:flutter/material.dart';

class WeekPerformanceScreen extends StatelessWidget {
  const WeekPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child: Scaffold(
        appBar: AppBar(
          title: const Text('공연'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/weekly-album'),
            child: const Text('다음'),
          ),
        ),
      ),
    );
  }
}
