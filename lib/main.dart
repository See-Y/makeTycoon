import 'package:flutter/material.dart';
import 'game_manager.dart'; // GameManager 추가
import 'package:provider/provider.dart';
import 'providers/band_provider.dart';

// Screens
import 'models/member.dart';
import 'screens/game_start/game_start_screen.dart';
import 'screens/month/month_main_screen.dart';
import 'screens/month/member_stats_screen.dart';
import 'screens/month/instrument_stats_screen.dart';
import 'screens/week/week_performance_screen.dart';
import 'screens/week/week_album_screen.dart';
import 'screens/week/week_rest_screen.dart';
import 'screens/month_summary/month_summary_screen.dart';
import 'screens/quarter/quarter_main_screen.dart';
import 'screens/quarter/member_removal_screen.dart';
import 'screens/quarter/member_recruitment_screen.dart';
import 'screens/game_start/band_name_screen.dart';
import 'package:make_tycoon/screens/month/member_level_up_screen.dart';


void main() {
  runApp(BandSimulationApp());
}

class BandSimulationApp extends StatelessWidget {
  const BandSimulationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final gameManager = GameManager(); // GameManager 싱글톤 인스턴스 초기화// 숨길 라우트 이름 리스트
    return ChangeNotifierProvider(
      create: (context) => BandProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/game-start',
        routes: {
        '/game-start': (context) => const GameStartScreen(),
        '/band-name': (context) => BandNameScreen(),
        //'/settings': (context) => const SettingsScreen(),
        '/monthly-cycle': (context) => const MonthMainScreen(),
        '/member-stats': (context) => MemberStatsScreen(),
        '/level-up': (context) {
          final member = ModalRoute.of(context)!.settings.arguments as Member;
          return MemberLevelUpScreen(member: member);
        },
        '/instrument-stats': (context) => const InstrumentStatsScreen(),
        '/week-performance': (context) => const WeekPerformanceScreen(),
        '/week-album': (context) => const WeekAlbumScreen(),
        '/week-rest': (context) => const WeekRestScreen(),
        '/monthly-summary': (context) => const MonthSummaryScreen(),
        '/quarter-main': (context) => const QuarterMainScreen(),
        '/member-removal': (context) => const MemberRemovalScreen(),
        '/member-recruitment': (context) => const MemberRecruitmentScreen(),
        }
      ),
    );
  }
}
