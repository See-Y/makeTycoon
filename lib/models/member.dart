import '../models/leader_effect.dart';
import '../models/effect_target.dart';
import '../models/effect_type.dart';
import 'instrument.dart';

class Member {
  final String name;
  final String animalType;
  Instrument instrument;
  int level;
  List<int> stats; // [관종, 똘끼, 깡, 스껄]
  final List<int> mbti; // [I/E, S/N, T/F, P/J]
  final LeaderEffect leaderEffect1; // 리더 패시브 효과 1
  final LeaderEffect leaderEffect2; // 리더 패시브 효과 2
  bool isLeader; // 리더 여부
  Map<Member, int> approvalRatings; // 다른 멤버들에 대한 지지율
  String? image;

  Member({
    required this.name,
    required this.animalType,
    required this.instrument,
    this.level = 1,
    required this.stats,
    required this.mbti,
    required this.leaderEffect1,
    required this.leaderEffect2,
    this.isLeader = false,
    Map<Member, int>? approvalRatings,
    this.image=null,
  }) : approvalRatings = approvalRatings ?? {};

  // 스탯 Getter: 리더 효과가 적용된 값을 반환
  List<int> get adjustedStats {
    final adjusted = List<int>.from(stats);

    // 리더 효과 1 적용
    if (isLeader) {
      if (leaderEffect1.type == EffectType.increase) {
        for (int i = 0; i < adjusted.length; i++) {
          adjusted[i] += leaderEffect1.value; // 모든 스탯에 value만큼 증가
        }
      } else {
        for (int i = 0; i < adjusted.length; i++) {
          adjusted[i] = (adjusted[i] - leaderEffect1.value).clamp(1, double.infinity).toInt();
          // 감소, 단 0 이하가 되지 않도록 clamp(1, 무한대)
        }
      }
    }

    // 리더 효과 2 적용
    if (isLeader) {
      if (leaderEffect2.type == EffectType.increase) {
        for (int i = 0; i < adjusted.length; i++) {
          adjusted[i] += leaderEffect2.value; // 모든 스탯에 value만큼 증가
        }
      } else {
        for (int i = 0; i < adjusted.length; i++) {
          adjusted[i] = (adjusted[i] - leaderEffect2.value).clamp(1, double.infinity).toInt();
          // 감소, 단 0 이하가 되지 않도록 clamp(1, 무한대)
        }
      }
    }

    return adjusted;
  }


  @override
  String toString() {
    return "이름: $name, 동물: $animalType, 악기: ${instrument.name}, "
        "스탯: $adjustedStats (기본 스탯: $stats), "
        "MBTI: $mbti, "
        "리더 효과 1: $leaderEffect1, 리더 효과 2: $leaderEffect2, "
        "지지율: ${approvalRatings.entries.map((e) => '${e.key.name}: ${e.value.toStringAsFixed(1)}').join(', ')}";
  }
}
