import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:make_tycoon/models/instrument.dart';
import '../data/instrument_enhance_data.dart';
import '../logic/instrument_enhance_logic.dart';
import '../models/band.dart';
import '../models/member.dart';
import '../models/album.dart';
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

  int _albumWorkWeeks = 0; // 음반 작업 주차 (5주가 되면 발매 가능)

  int get albumWorkWeeks => _albumWorkWeeks;

  void incrementAlbumWorkWeeks() {
    _albumWorkWeeks++;
    notifyListeners();
  }

  void resetAlbumWorkWeeks() {
    _albumWorkWeeks = 0;
    notifyListeners();
  }

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
    print("check InitialBand");
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
      money: 100,
    );
    print("check createInitialBand");
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
    print("check addmember:");
    notifyListeners();
  }

  /// 멤버 제거
  void removeMember(Member member) {
    ApprovalLogic.removeApprovalForMember(member, _band.members);
    _band.members.remove(member);
    print("check removeMember");
    notifyListeners();
  }

  void updateMoney(int newMoney){
    _band.money += newMoney;
    notifyListeners();
  }

  void updateFans(int newFansCount) {
    _band.fans += newFansCount;
    notifyListeners(); // UI에 즉시 반영
  }

  void updateMemberStats(Member member, List<int> updatedStats) {
    final index = _band.members.indexOf(member);
    if (index != -1) {
      _band.members[index].stats.setAll(0, updatedStats);
      print("check updateMemberStats");
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

  void addAlbum(String name, int fanBoost, int monthlyIncome, String? albumArt) {
    DateTime releaseDate = DateTime.now(); // 현재 시간을 발매일로 설정
    Album newAlbum = Album(
      name: name,
      releaseDate: releaseDate, // 발매일을 현재 시간으로 설정
      fanBoost: fanBoost,
      monthlyIncome: monthlyIncome,
      albumArt: albumArt,
    );
    _band.albums.add(newAlbum); // 앨범을 리스트에 추가
    notifyListeners(); // 상태 업데이트
  }

  List<int> getTotalMemberStats() {

    List<int> totalStats = [];
    totalStats.add(0);
    totalStats.add(0);
    totalStats.add(0);
    totalStats.add(0);

    for (var member in _band.members) {
      totalStats[0] += member.stats[0];  // 관종
      totalStats[1] += member.stats[1]; // 똘끼
      totalStats[2] += member.stats[2];   // 깡
      totalStats[3] += member.stats[3];   // 스껄

    }

    return totalStats;
  }

  double getTotalPerformanceQualityBoost() {
    double totalBoost = 0.0;

    for (var member in _band.members) {
      final instrument = member.instrument; // 각 멤버의 악기
      if (instrument != null && instrument.effects.containsKey('performanceBoost')) {
        totalBoost += instrument.effects['performanceBoost']!;
      }
    }

    return totalBoost;
  }


  double getTotalAlbumQualityBoost() {
    double totalBoost = 0.0;

    for (var member in _band.members) {
      final instrument = member.instrument; // 각 멤버의 악기
      if (instrument != null && instrument.effects.containsKey('albumQualityBoost')) {
        totalBoost += instrument.effects['albumQualityBoost']!;
      }
    }

    return totalBoost;
  }

  void applyMonthlySummary() {
    int totalMonthlyIncome = _band.albums.fold(0, (sum, album) => sum + album.monthlyIncome);
    int totalFanBoost = _band.albums.isEmpty? 0 : _band.albums.last.fanBoost;

    _band.money += totalMonthlyIncome;
    _band.money -=calculateMonthlyRent();
    _band.fans += totalFanBoost;

    notifyListeners();
  }

  int calculateMonthlyRent(){
    int rent = 10;
    rent += _band.members.length * 10;
    for (var member in _band.members){
      rent += (member.level - 1) * 20;
    }

    return rent;
  }

  void selectNewLeader(){
    Member leader= _band.members[0];
    int highestSupportSum = -9999;


    for (var member in _band.members){
      final approvalRatings = band.members.where((otherMember) => otherMember != member)
          .map((otherMember) {
        final approvalValue = otherMember.approvalRatings[member] ?? 0.0;
        return approvalValue;
      }).toList();
      int totalSupport = approvalRatings.reduce((a,b)=>a+b) as int;
      print("total Support ${member.name}:$totalSupport");
      if(totalSupport > highestSupportSum){
        highestSupportSum = totalSupport;
        leader = member;
      }
    }
    print("selectNewLeader called: ${_band.leader.name}");
    _band.leader.isLeader=false;
    leader.isLeader = true;
    _band.leader = leader;
    print("selectNewLeader changed: ${_band.leader.name}");
  }

  void updateLeaderApprovalRatings(bool isSuccess) {
    int change = isSuccess ? 1 : -3;  // 성공 시 지지율 증가 (+10), 실패 시 감소 (-30)

    for (var member in _band.members) {
      if (member != _band.leader) {  // 리더는 제외
        member.approvalRatings.update(
          _band.leader,
              (value) => (value + change).clamp(-10, 10),  // 범위를 -100 ~ 100으로 제한
          ifAbsent: () => change,  // 처음 지지율이 없으면 change 값으로 설정
        );
      }
    }
    notifyListeners();
  }





}
