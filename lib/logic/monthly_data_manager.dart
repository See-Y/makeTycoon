import '../models/venue.dart';

class MonthlyDataManager {
  static final MonthlyDataManager _instance = MonthlyDataManager._internal();
  factory MonthlyDataManager() => _instance;

  MonthlyDataManager._internal();

  // 주차별 활동 기록
  final List<WeeklyActivity?> weeklyActivities = [null, null, null, null];

  // 특정 주의 활동 설정
  void setWeeklyActivity(int week, WeeklyActivity activity) {
    weeklyActivities[week] = activity;
  }

  // 특정 주의 활동 가져오기
  WeeklyActivity? getWeeklyActivity(int week) {
    return weeklyActivities[week];
  }

  // 모든 주의 활동이 설정되었는지 확인
  bool isAllWeeksSelected() {
    return weeklyActivities.every((activity) => activity != null);
  }

  // 월간 데이터 초기화
  void resetMonthlyData() {
    for (int i = 0; i < weeklyActivities.length; i++) {
      weeklyActivities[i] = null;
    }
  }
}

// 주차별 활동 데이터를 담는 클래스
class WeeklyActivity {
  final String activityType; // "공연", "음반 작업", "휴식" 등
  final Venue? venue;
  final double? ticketPrice;
  final int? audienceCount;
  final int? fanChange;
  final double? revenue;
  final double? success;
  final int? albumWeek;
  final String? albumName;

  WeeklyActivity({
    required this.activityType,
    this.venue,
    this.ticketPrice,
    this.audienceCount,
    this.fanChange,
    this.revenue,
    this.success,
    this.albumWeek,
    this.albumName,
  });
}
