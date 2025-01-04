import '../models/leader_effect.dart';

class Member {
  final String name;
  final String animalType;
  final String instrument;
  final List<int> stats; // [관종, 똘끼, 깡, 스껄]
  final List<int> mbti; // [-100 ~ 100 벡터]
  final LeaderEffect leaderEffect1; // 리더 패시브 효과 1
  final LeaderEffect leaderEffect2; // 리더 패시브 효과 2

  Member({
    required this.name,
    required this.animalType,
    required this.instrument,
    required this.stats,
    required this.mbti,
    required this.leaderEffect1,
    required this.leaderEffect2,
  });

  @override
  String toString() {
    return "이름: $name, 동물: $animalType, 악기: $instrument, "
        "스탯: $stats, MBTI: $mbti, "
        "리더 효과 1: $leaderEffect1, 리더 효과 2: $leaderEffect2";
  }
}
