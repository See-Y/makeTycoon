class Venue {
  final String name;          // 공연장 이름
  final int fee;              // 대관료
  final int fanIncrease;      // 증가하는 팬 수
  final int maxAudience;      // 최대 수용 가능 관객 수 (옵션)
  final String description;   // 추가 설명 (옵션)

  Venue({
    required this.name,
    required this.fee,
    required this.fanIncrease,
    this.maxAudience = 0,     // 기본값 설정
    this.description = '',
  });

  @override
  String toString() {
    return "공연장: $name, 대관료: $fee원, 팬 증가: $fanIncrease명";
  }
}
