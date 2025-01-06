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
      appBar: AppBar(title: const Text('음반 발매')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 150,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(child: Text('앨범 아트를 선택하세요')),
              )
                  : Image.file(
                _albumArt!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _releaseAlbum,
              child: const Text('음반 발매하기'),
            ),
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
}
