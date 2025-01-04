import 'package:provider/provider.dart';
import 'dart:math';
import '../models/effect_target.dart';
import '../models/effect_type.dart';
import '../models/instrument.dart';
import '../models/member.dart';
import '../providers/band_provider.dart';
import '../data/instrument_enhance_data.dart';

class InstrumentEnhanceLogic {
  // 리더 이펙트를 고려한 최종 강화 확률 계산
  static Map<String, double> getAdjustedEnhanceRates(Member member, String rarity) {
    final rates = Map<String, double>.from(instrumentEnhanceRates[rarity]!);

    // 리더 효과 적용
    if (member.isLeader) {
      [member.leaderEffect1, member.leaderEffect2].forEach((effect) {
        if (effect.target == EffectTarget.enhancement) {
          final adjustment = effect.type == EffectType.increase ? effect.value / 100 : -effect.value / 100;
          rates['success'] = (rates['success']! + adjustment).clamp(0.0, 1.0); // 성공 확률 조정
          rates['downgrade'] = (rates['downgrade']! - adjustment).clamp(0.0, 1.0); // 등급 하락 확률 조정
        }
      });
    }

    return rates;
  }

  // 강화 결과 결정 및 BandProvider로 데이터 반영
  static String enhanceInstrument(Member member, Instrument instrument, int currentMoney) {
    final rarity = instrument.rarity;

    // 강화 비용 확인
    final cost = instrumentEnhanceCosts[rarity]!;
    if (currentMoney < cost) {
      return "돈이 부족합니다.";
    }

    // 강화 확률 가져오기
    final rates = getAdjustedEnhanceRates(member, rarity);
    final rand = Random().nextDouble();

    if (rand < rates['success']!) {
      // 강화 성공
      instrument.rarity = _getNextRarity(rarity);
      instrument.updateEffects(); // 희귀도 변경 후 효과 업데이트
      return "강화 성공! 희귀도: ${instrument.rarity}";
    } else if (rand < rates['success']! + rates['downgrade']!) {
      // 등급 하락
      instrument.rarity = _getPreviousRarity(rarity);
      instrument.updateEffects(); // 희귀도 변경 후 효과 업데이트
      return "강화 실패로 등급 하락! 현재 희귀도: ${instrument.rarity}";
    } else {
      // 강화 실패
      return "강화 실패! 희귀도 유지: ${instrument.rarity}";
    }
  }


  // 다음 희귀도 반환
  static String _getNextRarity(String rarity) {
    const rarities = ['일반', '레어', '유니크', '레전드', '신화'];
    final index = rarities.indexOf(rarity);
    return index < rarities.length - 1 ? rarities[index + 1] : '신화';
  }

  // 이전 희귀도 반환
  static String _getPreviousRarity(String rarity) {
    const rarities = ['일반', '레어', '유니크', '레전드', '신화'];
    final index = rarities.indexOf(rarity);
    return index > 0 ? rarities[index - 1] : '일반';
  }
}
