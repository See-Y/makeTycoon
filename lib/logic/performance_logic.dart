import 'dart:math';

import '../models/member.dart';
import '../models/venue.dart';
import '../models/leader_effect.dart';
import '../models/effect_target.dart';
import '../models/effect_type.dart';

class PerformanceLogic {
  // 1. 관객 수 계산
  static double calculateAudienceCount(double ticketPrice, int fanCount, Venue venue) {
    double idealPrice = venue.idealPrice;

    // 기본 관객 수: 공연장 최대 관객 수의 10%
    double baseAudience = venue.maxAudience * 0.1;

    // 티켓 가격에 따른 조정
    if (ticketPrice <= idealPrice) {
      // 산술적으로 증가
      baseAudience *= (1 + (idealPrice - ticketPrice) / idealPrice * 0.5);
    } else {
      // 기하급수적으로 감소
      baseAudience *= pow(0.5, (ticketPrice - idealPrice) / idealPrice);
    }

    // 팬 수의 영향 반영
    double fanInfluence = fanCount * 0.5;

    // 최종 관객 수 계산 (공연장 최대 관객 수로 제한)
    return min(venue.maxAudience.toDouble(), baseAudience + fanInfluence);
  }

  // 2. 공연 성공률 계산
  static double calculateSuccessRate(List<Member> members, Member leader) {
    // 악기 효과 합산
    double performanceBoost = members.fold(0.0, (sum, member) {
      return sum + (member.instrument.effects['performanceBoost'] ?? 0.0);
    });

    // 리더 효과 적용
    double leaderEffect = 0.0;
    if (leader.isLeader) {
      leaderEffect = leader.leaderEffect1.target == EffectTarget.performance
          ? (leader.leaderEffect1.type == EffectType.increase
          ? leader.leaderEffect1.value / 100.0
          : -leader.leaderEffect1.value / 100.0)
          : 0.0;
    }
    final random = Random();
    final double randomValue = 0.2 + random.nextDouble() * (2.0 - 0.5);

    // 성공률 계산
    return randomValue * (1 + performanceBoost) + leaderEffect;
  }

  // 3. 공연 수익 계산
  static double calculatePerformanceRevenue(
      double audienceCount, double ticketPrice, double successRate, List<Member> members) {
    // 멤버들의 '깡' 스탯 총합
    double gutsTotal = members.fold(0.0, (sum, member) => sum + member.stats[2]);

    // 수익 계산
    return audienceCount.toInt() * ticketPrice * successRate * (1 + gutsTotal * 0.01);
  }

  // 4. 팬 증가 계산
  static int calculateFanIncrease(double successRate, Venue venue, List<Member> members, double audience) {
    // 멤버들의 '관종' 스탯 총합
    double attentionSeekerTotal =
    members.fold(0.0, (sum, member) => sum + member.stats[0]);

    // 팬 증가 계산
    return min(audience, min(venue.fanIncrease, audience*0.1) * successRate * (1 + attentionSeekerTotal * 0.01)).floor();
  }

  // 5. 팬 감소 계산 (공연 실패 시)
  static int calculateFanDecrease(double successRate, int currentFans) {
    if (successRate >= 1.0) return 0; // 성공이면 감소 없음

    // 실패율 계산
    double failureRate = 1.0 - successRate;

    // 팬 감소량 계산
    return -(currentFans * failureRate * 0.05).round();
  }
}
