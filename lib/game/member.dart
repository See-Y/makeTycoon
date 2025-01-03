class Member {
  final String name; // 멤버 이름
  final String animalType; // 동물 종류
  final String instrument; // 다루는 악기
  final List<int> mbti; // [-100, 100] 형태의 MBTI 벡터
  final Map<String, int> stats; // {"관종": 5, "똘끼": 7, ...}
  int approvalRating; // 멤버 지지율

  Member({
    required this.name,
    required this.animalType,
    required this.instrument,
    required this.mbti,
    required this.stats,
    this.approvalRating = 0,
  });

  @override
  String toString() {
    return 'Name: $name, Animal: $animalType, Instrument: $instrument, Stats: $stats, MBTI: $mbti, Approval: $approvalRating';
  }
}
