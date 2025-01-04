import 'effect_target.dart';
import 'effect_type.dart';

class LeaderEffect {
  final String description; // 효과 설명
  final EffectTarget target; // 효과 대상
  final EffectType type; // 효과 유형
  final int value; // 효과 값 (퍼센트 또는 고정 값)

  LeaderEffect({
    required this.description,
    required this.target,
    required this.type,
    required this.value,
  });

  // 한글 설명 제공 메서드
  String getTargetDescription() {
    return effectTargetDescriptions[target] ?? target.toString();
  }

  String getTypeDescription() {
    return effectTypeDescriptions[type] ?? type.toString();
  }
}
