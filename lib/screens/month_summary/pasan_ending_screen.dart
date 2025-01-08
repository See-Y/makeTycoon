import 'package:flutter/material.dart';
import '../game_start/band_name_screen.dart';

class PasaNendingScreen extends StatelessWidget {
  const PasaNendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게임 종료', textAlign: TextAlign.center),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,  // 파산에 맞는 강렬한 색상
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // 수직 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.center,  // 수평 중앙 정렬
            children: [
              // 파산 메시지
              const Text(
                '당신은 파산했습니다.\n멤버들은 해체하여 밤거리의 불량배가 됩니다.', textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,

                ),
              ),
              const SizedBox(height: 20),  // 사진과 텍스트 사이의 간격
              // 절망적인 사진
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'assets/gifs/노숙자.gif',  // 파산을 상징하는 이미지 경로
                  width: MediaQuery.of(context).size.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),  // 이미지와 버튼 사이의 간격

              // '처음부터' 버튼
              _buildCustomButton(context, '처음부터', () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BandNameScreen()),
                );
              }),
            ],
          ),
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
                fontFamily: 'DungGeunMo',  // 폰트 패밀리
              ),
            ),
          ),
        ),
      ),
    );
  }
}

