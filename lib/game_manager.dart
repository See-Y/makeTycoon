class GameManager {
  static final GameManager _instance = GameManager._internal();

  factory GameManager() => _instance;

  GameManager._internal();

  int currentMonth = 1; // 현재 월 (초기값)

  void incrementMonth() {
    currentMonth++;
    if (currentMonth > 12) {
      currentMonth = 1; // 12월 이후 1월로 리셋
    }
  }

  bool isQuarterStart() {
    return currentMonth % 3 == 0; // 3, 6, 9, 12월일 때 분기 시작
  }
}
