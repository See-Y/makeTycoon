import 'dart:math';
import '../models/member.dart';
import '../data/member_data.dart';
import '../data/member_name_data.dart';

class MemberCreationLogic {
  // 악기에 맞는 멤버 데이터 가져오기
  static Map<String, dynamic> getMemberData(String instrument) {
    final result = memberData.where((data) => data["instrument"] == instrument);

    if (result.isEmpty) {
      throw Exception("유효하지 않은 악기입니다: $instrument");
    }

    return result.first; // 조건에 맞는 첫 번째 데이터를 반환
  }

  // 멤버 생성
  static Member createMember(String instrument) {
    final data = getMemberData(instrument);

    final random = Random();

    // 랜덤 이름 가져오기
    final name = memberNames[random.nextInt(memberNames.length)];

    // 랜덤 스탯 생성
    final stats = List<int>.generate(4, (_) => random.nextInt(10) + 1);

    // 랜덤 MBTI 생성 (-100 ~ 100 범위)
    final mbti = List<int>.generate(4, (_) => random.nextInt(201) - 100);

    return Member(
      name: name,
      animalType: data["animalType"],
      instrument: data["instrument"],
      stats: stats,
      mbti: mbti,
      leaderEffect1: data["leaderEffect1"],
      leaderEffect2: data["leaderEffect2"],
    );
  }
}
