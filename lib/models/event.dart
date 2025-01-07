class Event {
  final String name;
  final String description;
  final String imagePath;
  final List<String> choices;
  final void Function(int choiceIndex) resolveEvent;

  Event({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.choices,
    required this.resolveEvent,
  });

  // bool isTriggered(Map<String, dynamic> currentState) {
  //   // 조건과 현재 상태 비교하여 이벤트 발생 여부 확인
  //   return conditions.entries.every((entry) =>
  //   currentState.containsKey(entry.key) &&
  //       currentState[entry.key] == entry.value);
  // }
}
