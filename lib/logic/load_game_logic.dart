import 'package:flutter/material.dart';
import 'package:make_tycoon/providers/band_provider.dart';
import 'package:make_tycoon/logic/member_creation_logic.dart';
import 'package:make_tycoon/models/member.dart';
import 'package:make_tycoon/models/instrument.dart';
import 'package:provider/provider.dart';
import '../game_manager.dart';

/// 서버에서 받아온 데이터를 GameManager와 BandProvider에 적용하는 함수
void applyLoadedData(BuildContext context, Map<String, dynamic> loadedData) {
  final gameManager = GameManager();
  final bandProvider = Provider.of<BandProvider>(context);

  // 1. GameManager 업데이트
  gameManager.currentYear = loadedData['current_year'];
  gameManager.currentMonth = loadedData['current_month'];
  gameManager.currentWeek = loadedData['current_week'];

  // 2. BandProvider 업데이트
  bandProvider.band.name = loadedData['band_name'];
  bandProvider.band.fans = loadedData['fans'];
  bandProvider.band.money = loadedData['money'];

  // 멤버 리스트 업데이트
  final members = (loadedData['members'] as List<dynamic>).map((memberData) {
    final instrument = Instrument(
      name: memberData['instrument_name'],
      rarity: memberData['instrument_rarity'],
    );
    instrument.updateEffects();
    final instrumentBindData = MemberCreationLogic.getMemberData(instrument);
    return Member(
      name: memberData['name'],
      animalType: instrumentBindData["animalType"],
      instrument: instrument,
      level: memberData['level'],
      stats: List<int>.from(memberData['stats']),
      mbti: List<int>.from(memberData['mbti']),
      leaderEffect1: instrumentBindData["leaderEffect1"],
      leaderEffect2: instrumentBindData["leaderEffect2"],
      isLeader: memberData['is_leader'],
    );
  }).toList();
  bandProvider.band.members = members;

  // 리더 설정
  bandProvider.band.leader = bandProvider.band.members.firstWhere((member) => member.isLeader, orElse: () {
    return bandProvider.band.members[0];
  });

  // 지지율 설정
  final List<dynamic> loadedMembers = loadedData['members'];
  for (final loadedMember in loadedMembers) {
    final String memberName = loadedMember['name'];
    final Map<String, int> loadedRatings = Map<String, int>.from(loadedMember['approval_ratings']);

    // 해당 멤버 찾기
    final targetMember = members.firstWhere(
          (member) => member.name == memberName,
      orElse: () => throw Exception('Member not found: $memberName'),
    );

    if (targetMember != null) {
      // 지지율 복원
      targetMember.approvalRatings.clear(); // 기존 지지율 초기화
      loadedRatings.forEach((otherMemberName, rating) {
        // 다른 멤버 객체 찾기
        final otherMember = members.firstWhere(
              (member) => member.name == otherMemberName,
          orElse: () => throw Exception('Member not found: $memberName'),
        );

        if (otherMember != null) {
          targetMember.approvalRatings[otherMember] = rating;
        }
      });
    }
  }

  gameManager.setavailableMember(context);
  // GameManager.membername
  gameManager.membername = members.map((member) => member.name).toList();

  // 데이터 적용 완료
  bandProvider.notifyListeners();
}
