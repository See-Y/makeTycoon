import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Game Manager
import 'game_manager.dart';

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

// Band Provider
import 'providers/band_provider.dart';

void main() {
  runApp(const BandSimulationApp());
}

class BandSimulationApp extends StatelessWidget {
  const BandSimulationApp({super.key});

  @override
  Widget build(BuildContext context) {
    // GameManager 싱글톤 초기화
    final gameManager = GameManager();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BandProvider()), // BandProvider 등록
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const GameStartScreen(),
          '/monthly-cycle': (context) => const MonthMainScreen(),
          '/member-stats': (context) => const MemberStatsScreen(),
          '/instrument-stats': (context) => const InstrumentStatsScreen(),
          '/week-performance': (context) => const WeekPerformanceScreen(),
          '/week-album': (context) => const WeekAlbumScreen(),
          '/week-rest': (context) => const WeekRestScreen(),
          '/monthly-summary': (context) => const MonthSummaryScreen(),
          '/quarter-main': (context) => const QuarterMainScreen(),
          '/member-removal': (context) => const MemberRemovalScreen(),
          '/member-recruitment': (context) => const MemberRecruitmentScreen(),
        },
      ),
    );
  }
}
