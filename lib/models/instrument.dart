class Instrument {
  final String name;
  final String type; // 예: "기타", "드럼"
  int level;
  String rarity; // 예: "레어", "전설"
  double successRate; // 강화 성공 확률

  Instrument({
    required this.name,
    required this.type,
    this.level = 1,
    this.rarity = "일반",
    this.successRate = 0.8,
  });

  void upgrade() {
    successRate *= 0.9; // 레벨업 시 성공률 감소
    level++;
  }
}
