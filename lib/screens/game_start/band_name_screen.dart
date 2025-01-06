import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';
import '../../game_manager.dart';
import '../month/month_main_screen.dart';

class BandNameScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('밴드 이름 설정'),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
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
            _buildCustomButton(context, '밴드 출격!', () {
              // 처음부터 버튼 클릭 시 실행할 함수
              final bandName = _nameController.text.trim();
              if (bandName.isNotEmpty) {
                Provider.of<BandProvider>(context, listen: false).createInitialBand(bandName); // 새로운 Band 생성
                GameManager().setavailableMember(context);
                Navigator.pushNamed(context, '/monthly-cycle');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('밴드 이름을 입력해주세요!')),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton(BuildContext context, String label, VoidCallback onPressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75, // 화면의 3/4 너비
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16), // 버튼 높이
          decoration: BoxDecoration(
            color: Colors.black, // 버튼 배경 색상
            borderRadius: BorderRadius.circular(25), // 둥근 직사각형
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // 그림자 색상
                offset: Offset(0, 5), // 그림자 위치 (X, Y)
                blurRadius: 10, // 그림자 흐림 정도
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,   // 텍스트 색상
                fontSize: 20,          // 폰트 크기
                fontWeight: FontWeight.bold, // 폰트 두께
                fontFamily: 'Roboto',  // 폰트 패밀리
              ),
            ),
          ),
        ),
      ),
    );
  }

}