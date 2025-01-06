import '../models/member.dart';
import '../models/instrument.dart';
import '../models/leader_effect.dart';
import '../providers/band_provider.dart';
import '../models/effect_type.dart';
import '../models/effect_target.dart';
import 'dart:math';

class AlbumLogic {
  // 팬 증가량(fanBoost) 계산, 영향을 주는 것: 멤버 스탯 총합, 악기 스탯 총합, 리더 스킬, 랜덤 가중치(명반 탄생 확률)
  static final Random random = Random();
  static final double goodalbum = random.nextDouble(); //얼마나 명반인지

  static int calculateFanBoost(BandProvider bandProvider) {
    final double baseFanBoost = 40 + (goodalbum * 20); // 40 ~ 60
    List<int> totalStats=bandProvider.getTotalMemberStats(); //멤버 스탯 총합 어레이
    double quirkiness = totalStats[1] * 0.01; //똘끼
    double albumQualityBoost = bandProvider.getTotalAlbumQualityBoost(); //악기 스탯 총합
    Member leader=bandProvider.band.leader;
    double incomeBoost = leader.leaderEffect1.type == EffectType.increase && leader.leaderEffect1.target == EffectTarget.album
        ? leader.leaderEffect1.value / 100.0
        : 0.0;
    double incomeBoost2 = leader.leaderEffect2.type == EffectType.increase && leader.leaderEffect2.target == EffectTarget.album
        ? leader.leaderEffect2.value / 100.0
        : 0.0;
    return (baseFanBoost * (1 + albumQualityBoost + incomeBoost + incomeBoost2) * (1+quirkiness)).toInt();
  }

  // 월간 고정 수익(monthlyIncome) 계산, 영향을 주는 것: 멤버 스탯 총합, 악기 스탯 총합, 리더 스킬, 랜덤 가중치(명반 탄생 확률)
  static int calculateMonthlyIncome(BandProvider bandProvider) {
    final double baseIncome = 10 + (goodalbum * 20); // 10 만 원 ~ 30 만 원
    List<int> totalStats=bandProvider.getTotalMemberStats(); //멤버 스탯 총합 어레이
    double albumQualityBoost = bandProvider.getTotalAlbumQualityBoost(); //악기 스탯 총합
    double skrrr=totalStats[3] * 0.01;
    Member leader=bandProvider.band.leader;
    double incomeBoost = leader.leaderEffect1.type == EffectType.increase && leader.leaderEffect1.target == EffectTarget.album
        ? leader.leaderEffect1.value / 100.0
        : 0.0;
    double incomeBoost2 = leader.leaderEffect2.type == EffectType.increase && leader.leaderEffect2.target == EffectTarget.album
        ? leader.leaderEffect2.value / 100.0
        : 0.0;
    return (baseIncome * (1 + albumQualityBoost + incomeBoost + incomeBoost2) * (1+skrrr)).toInt();
  }
}
