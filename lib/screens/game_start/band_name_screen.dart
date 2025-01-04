import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';
import '../../game_manager.dart';
import '../month/month_main_screen.dart';

class BandNameScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('밴드 이름 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '세계적인 락스타가 될 밴드의 이름을 지어주세요!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '밴드 이름',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final bandName = _nameController.text.trim();
                if (bandName.isNotEmpty) {
                  Provider.of<BandProvider>(context, listen: false).createInitialBand(bandName); // 새로운 Band 생성
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MonthMainScreen()), //month_main_screen으로 이동
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('밴드 이름을 입력해주세요!')),
                  );
                }
              },
              child: const Text('시작하기!'),
            ),
          ],
        ),
      ),
    );
  }
}
