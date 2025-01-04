class Event {
  final String name;
  final String description;
  final Map<String, dynamic> conditions; // 예: {"type": "공연", "rainy": true}
  final Map<String, dynamic> outcomes; // 예: {"fans": 100, "money": -50}

  Event({
    required this.name,
    required this.description,
    required this.conditions,
    required this.outcomes,
  });

  bool isTriggered(Map<String, dynamic> currentState) {
    // 조건과 현재 상태 비교하여 이벤트 발생 여부 확인
    return conditions.entries.every((entry) =>
    currentState.containsKey(entry.key) &&
        currentState[entry.key] == entry.value);
  }
}
