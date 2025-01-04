import '../data/instrument_effect_data.dart';

class Instrument {
  final String name; // 악기 이름
  String rarity; // 희귀도: 일반 → 신화
  Map<String, double> effects; // 공연 및 음반 효과

  Instrument({
    required this.name,
    this.rarity = '일반',
  }) : effects = Map<String, double>.from(instrumentEffects['일반']!);

  // 희귀도에 따라 효과 업데이트
  void updateEffects() {
    if (instrumentEffects.containsKey(rarity)) {
      effects = Map<String, double>.from(instrumentEffects[rarity]!);
    }
  }

  @override
  String toString() {
    return "악기: $name, 희귀도: $rarity, 효과: $effects";
  }
}
