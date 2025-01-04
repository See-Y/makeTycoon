class MonthlyDataManager {
  static final MonthlyDataManager _instance = MonthlyDataManager._internal();
  factory MonthlyDataManager() => _instance;

  MonthlyDataManager._internal();

  List<String?> weeklyActivities = [null, null, null, null]; // 주별 활동 저장

  void setWeeklyActivity(int week, String activity) {
    weeklyActivities[week] = activity;
  }

  String? getWeeklyActivity(int week) {
    return weeklyActivities[week];
  }

  bool isAllWeeksSelected() {
    return weeklyActivities.every((activity) => activity != null);
  }

  void resetMonthlyData() {
    weeklyActivities = [null, null, null, null];
  }
}
