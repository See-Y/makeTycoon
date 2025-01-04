import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/band.dart';
import '../models/member.dart';
import 'dart:math';
import '../logic/member_creation_logic.dart';

class BandProvider with ChangeNotifier {
  Band _band = Band(name: '새로운 밴드', leader: MemberCreationLogic.createMember("보컬"), members: [], albums: [], fans: 0, money: 0);
  Band get band => _band;
  late List<Member> bandMembers;

  // 밴드 초기화
  void initializeBand() {
    // 1. 필수 멤버: 보컬 생성
    final vocal = MemberCreationLogic.createMember("보컬");

    // 2. 나머지 악기 목록
    final remainingInstruments = ["기타", "베이스", "드럼", "키보드"];

    // 3. 랜덤으로 2명의 악기를 선택
    final random = Random();
    remainingInstruments.shuffle(random); // 악기 순서를 랜덤으로 섞음
    final selectedInstruments = remainingInstruments.take(2);

    // 4. 선택된 악기로 멤버 생성
    final additionalMembers = selectedInstruments
        .map((instrument) => MemberCreationLogic.createMember(instrument))
        .toList();

    // 5. 밴드 구성
    bandMembers = [vocal, ...additionalMembers];
  }

  void createInitialBand(String bandName){
    initializeBand();
    _band = Band(
      name: bandName,
      leader: bandMembers[0],
      members: bandMembers,
      albums: [],
      fans: 0,
      money: 1000,
    );
    notifyListeners();

  }

  // 밴드의 리더를 변경하는 메서드
  void updateLeader(Member newLeaderName) {
    _band.leader = newLeaderName;
    notifyListeners();
  }

  // 밴드에 새로운 멤버를 추가하는 메서드
  void addMember(Member memberName) {
    _band.members.add(memberName);
    notifyListeners();
  }

  // 팬 수를 업데이트하는 메서드
  void updateFans(int newFansCount) {
    _band.fans = newFansCount;
    notifyListeners();
  }

  // 돈을 업데이트하는 메서드
  void updateMoney(int newAmount) {
    _band.money = newAmount;
    notifyListeners();
  }
}
