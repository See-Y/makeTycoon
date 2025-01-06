import 'package:flutter/material.dart';

class GameStartScreen extends StatelessWidget {
  const GameStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFAE2B0A),
        appBar: AppBar(
          title: const Text('스껄한 밴드를 만들어 보아요'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Column(
          children: [
            SizedBox(height: 100),
            Image.asset(
              'assets/images/coverage.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
            Positioned(
              bottom: 50, // 화면 아래에서부터의 거리
              left: MediaQuery.of(context).size.width * 0.125, // 가운데 정렬 (화면 너비의 1/8)
              right: MediaQuery.of(context).size.width * 0.125,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCustomButton(context, '처음부터', () {
                  // 처음부터 버튼 클릭 시 실행할 함수
                    Navigator.pushNamed(context, '/band-name'); // 게임 시작 로직
                  }),
                  SizedBox(height: 16), // 버튼 사이 간격
                  _buildCustomButton(context, '계속하기', () {
                  // 계속하기 버튼 클릭 시 실행할 함수
                    Navigator.pushNamed(context, '/continue-game'); // 계속하기 로직
                  }),
                ],
              ),
            ),
          ],
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
