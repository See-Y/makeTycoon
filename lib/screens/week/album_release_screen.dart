import 'package:flutter/material.dart';
import '../../game_manager.dart';
import 'package:image_picker/image_picker.dart';
import '../../logic/monthly_data_manager.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';
import '../../logic/album_logic.dart';
import 'dart:io';

class AlbumReleaseScreen extends StatefulWidget {
  @override
  _AlbumReleaseScreenState createState() => _AlbumReleaseScreenState();
}

class _AlbumReleaseScreenState extends State<AlbumReleaseScreen> {
  final TextEditingController albumNameController = TextEditingController();
  File? _albumArt; // 선택한 앨범 아트 파일
  Future<void> _pickAlbumArt() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _albumArt = File(pickedFile.path);
      });
    }
  }

  void _releaseAlbum() {
    if (albumNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('음반 이름을 입력해주세요!')),
      );
      return;
    }

    final bandProvider = Provider.of<BandProvider>(context, listen: false);
    final text = albumNameController.text;
    final fanBoost = AlbumLogic.calculateFanBoost(bandProvider);
    final fixedIncome = AlbumLogic.calculateMonthlyIncome(bandProvider);

    bandProvider.addAlbum(
      text,
      fanBoost,
      fixedIncome,
      _albumArt?.path, // 앨범 아트 경로
    );
    bandProvider.resetAlbumWorkWeeks();

    final gameManager = GameManager();

    MonthlyDataManager().setWeeklyActivity(
      gameManager.currentWeek - 1,
      WeeklyActivity(
        activityType: "앨범 출시",
        venue: null,
        ticketPrice: null,
        audienceCount: null,
        fanChange: fanBoost,
        revenue: fixedIncome.toDouble(),
        success: null,
        albumName: text,
      ),
    );

    _onActivityComplete(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('음반 발매가 가능합니다!'), automaticallyImplyLeading: false,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: albumNameController,
              decoration: const InputDecoration(labelText: '음반 이름'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _pickAlbumArt,
              child: _albumArt == null
                  ? Container(
                height: MediaQuery.of(context).size.width*0.8,
                width: MediaQuery.of(context).size.width*0.8,
                color: Colors.grey[300],
                child: const Center(child: Text('앨범 아트를 선택하세요')),
              )
                  : Image.file(
                _albumArt!,
                height: MediaQuery.of(context).size.width*0.8,
                width: MediaQuery.of(context).size.width*0.8,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            _buildCustomButton(context, '음반 발매하기', () {
              _releaseAlbum();
            }),
          ],
        ),
      ),
    );
  }

  void _onActivityComplete(BuildContext context) {
    final gameManager = GameManager();

    if (gameManager.currentWeek < 4) {
      // 다음 주차로 진행
      gameManager.incrementWeek();
      _navigateToNextWeek(context);
    } else {
      // 월간 주기 종료
      gameManager.incrementWeek();
      //MonthlyDataManager().resetMonthlyData(); // 활동 데이터 초기화
      Navigator.pushNamed(context, '/monthly-summary');
    }
  }

  void _navigateToNextWeek(BuildContext context) {
    final manager = MonthlyDataManager();
    final nextWeekActivity = manager.getWeeklyActivity(GameManager().currentWeek - 1)?.activityType;

    if (nextWeekActivity == "공연") {
      Navigator.pushNamed(context, '/week-performance');
    } else if (nextWeekActivity == "음반 작업") {
      Navigator.pushNamed(context, '/week-album');
    } else if (nextWeekActivity == "휴식") {
      Navigator.pushNamed(context, '/week-rest');
    }
  }

  Widget _buildCustomButton(BuildContext context, String label, VoidCallback onPressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5, // 화면의 3/4 너비
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
