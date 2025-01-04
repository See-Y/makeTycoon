import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:make_tycoon/models/instrument.dart';
import '../data/instrument_enhance_data.dart';
import '../logic/instrument_enhance_logic.dart';
import '../models/band.dart';
import '../models/member.dart';
import '../logic/member_creation_logic.dart';
import '../logic/approval_logic.dart';

class BandProvider with ChangeNotifier {
  Band _band = Band(
    name: '새로운 밴드',
    leader: MemberCreationLogic.createMember(Instrument(name: "보컬"), true),
    members: [],
    albums: [],
    fans: 0,
    money: 0,
  );
  Band get band => _band;
  late List<Member> bandMembers;

  /// 밴드 초기화
  void initializeBand() {
    // 1. 필수 멤버: 보컬 생성
    final vocal = MemberCreationLogic.createMember(Instrument(name: "보컬"), true);

    // 2. 나머지 악기 목록
    final remainingInstruments = ["기타", "베이스", "드럼", "키보드"];

    // 3. 랜덤으로 2명의 악기를 선택
    final random = Random();
    remainingInstruments.shuffle(random);
    final selectedInstruments = remainingInstruments.take(2);

    // 4. 선택된 악기로 멤버 생성
    final additionalMembers = selectedInstruments
        .map((instrument) => MemberCreationLogic.createMember(Instrument(name: instrument), false))
        .toList();

    // 5. 밴드 구성
    bandMembers = [vocal, ...additionalMembers];

    // 6. 초기 지지율 설정
    ApprovalLogic.initializeApprovalRatings(bandMembers);
  }

  /// 밴드 생성
  void createInitialBand(String bandName) {
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

  /// 리더 변경
  void updateLeader(Member newLeader) {
    final oldLeader = _band.leader;

    // 리더 상태 업데이트
    oldLeader.isLeader = false;
    newLeader.isLeader = true;

    // 밴드 리더 변경
    _band.leader = newLeader;
    notifyListeners();
  }

  /// 멤버 추가
  void addMember(Member newMember) {
    ApprovalLogic.addApprovalForNewMember(newMember, _band.members);
    _band.members.add(newMember);
    notifyListeners();
  }

  /// 멤버 제거
  void removeMember(Member member) {
    ApprovalLogic.removeApprovalForMember(member, _band.members);
    _band.members.remove(member);
    notifyListeners();
  }

  void updateMoney(int newMoney){
    _band.money = newMoney;
    notifyListeners();
  }

  void updateMemberStats(Member member, List<int> updatedStats) {
    final index = _band.members.indexOf(member);
    if (index != -1) {
      _band.members[index].stats.setAll(0, updatedStats);
      notifyListeners();
    }
  }

  void incrementMemberLevel(Member member) {
    final index = _band.members.indexOf(member);
    if (index != -1) {
      _band.members[index].level += 1;
      notifyListeners();
    }
  }

  // 악기 강화 메서드
  String enhanceInstrument(Member member, Instrument instrument) {
    final upgradeCost = instrumentEnhanceCosts[instrument.rarity]!;
    final message = InstrumentEnhanceLogic.enhanceInstrument(
      member,
      instrument,
      _band.money,
    );

    if (!message.contains("돈이 부족합니다")) {
      // 강화 성공 또는 실패: 밴드 돈 차감
      _band.money -= upgradeCost;

      // 상태 변경 반영
      notifyListeners();
    }

    return message;
  }


}
