import 'package:flutter/material.dart';

class WeekAlbumScreen extends StatelessWidget {
  const WeekAlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child: Scaffold(
        appBar: AppBar(
          title: const Text('음반'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/weekly-rest'),
            child: const Text('다음'),
          ),
        ),
      ),
    );
  }
}
