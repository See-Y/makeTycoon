import 'dart:math';
import 'package:flame/game.dart';
import 'package:make_tycoon/models/instrument.dart';
import 'package:make_tycoon/game_manager.dart';

import '../models/member.dart';
import '../data/member_data.dart';
import '../data/member_name_data.dart';

class MemberCreationLogic {
  // 악기에 맞는 멤버 데이터 가져오기
  static Map<String, dynamic> getMemberData(Instrument instrument) {
    final result = memberData.where((data) => data["instrument"] == instrument.name);

    if (result.isEmpty) {
      throw Exception("유효하지 않은 악기입니다: $instrument.name");
    }

    return result.first; // 조건에 맞는 첫 번째 데이터를 반환
  }

  static String getRandomMemberName(){
    String newName="망함";
    do {
      // memberNameData에서 랜덤으로 이름을 선택
      newName = (memberNames..shuffle()).first;
    } while (GameManager().membername.contains(newName));
    return newName;
  }

  // 멤버 생성
  static Member createMember(Instrument instrument, bool isLeader) {
    final data = getMemberData(instrument);

    final random = Random();

    // 랜덤 이름 가져오기
    final name = getRandomMemberName();
    GameManager().addmembername(name);

    // 랜덤 스탯 생성
    final stats = List<int>.generate(4, (_) => random.nextInt(10) + 1);

    // 랜덤 MBTI 생성 (-100 ~ 100 범위)
    final mbti = List<int>.generate(4, (_) => random.nextInt(201) - 100);

    return Member(
      name: name,
      animalType: data["animalType"],
      instrument: instrument,
      stats: stats,
      mbti: mbti,
      isLeader: isLeader,
      leaderEffect1: data["leaderEffect1"],
      leaderEffect2: data["leaderEffect2"],
      image: data["image"],
      position: List<double>.from(data["position"]),
    );
  }
}