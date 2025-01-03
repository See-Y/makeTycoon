import 'package:flutter/material.dart';
import 'game_manager.dart'; // GameManager 추가

// Screens
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

void main() {
  runApp(const BandSimulationApp());
}

class BandSimulationApp extends StatelessWidget {
  const BandSimulationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final gameManager = GameManager(); // GameManager 싱글톤 인스턴스 초기화

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const GameStartScreen(),
        '/monthly-cycle': (context) => const MonthMainScreen(),
        '/member-stats': (context) => const MemberStatsScreen(),
        '/instrument-stats': (context) => const InstrumentStatsScreen(),
        '/weekly-performance': (context) => const WeekPerformanceScreen(),
        '/weekly-album': (context) => const WeekAlbumScreen(),
        '/weekly-rest': (context) => const WeekRestScreen(),
        '/monthly-summary': (context) => const MonthSummaryScreen(),
        '/quarter-main': (context) => const QuarterMainScreen(),
        '/member-removal': (context) => const MemberRemovalScreen(),
        '/member-recruitment': (context) => const MemberRecruitmentScreen(),
      },
    );
  }
}
