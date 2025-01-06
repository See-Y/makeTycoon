import 'providers/band_provider.dart';
import 'package:provider/provider.dart';
import 'logic/member_creation_logic.dart';
import 'models/member.dart';
import 'package:flutter/material.dart';
import 'data/member_data.dart';
import 'models/instrument.dart';

class GameManager {
  static final GameManager _instance = GameManager._internal();

  factory GameManager() => _instance;

  GameManager._internal();

  // 시간적 흐름
  int currentYear = 1; // 현재 년도 (초기값)
  int currentMonth = 1; // 현재 월 (1~12)
  int currentWeek = 1;  // 현재 주차 (1~4)
  bool isMonthComplete = false; // 월간 주기 완료 여부
  bool isGameOver = false; // 게임 종료 여부
  List<String> membername= [];
  List<Member> availableMembers = [];

  late BandProvider bandProvider;


  List<Member> _getAllPotentialMembers() {

    List<Member> potentialMembers = [];

    for (var member in memberData){
      var newMember = MemberCreationLogic.createMember(Instrument(name: member['instrument']), false);
      potentialMembers.add(newMember);
    }

    return potentialMembers;
  }

  List<Member> _generateNewMembers(BandProvider bandProvider) {
    // 가능성 있는 멤버 목록을 가져와
    List<Member> allPotentialMembers = _getAllPotentialMembers();
    List<Member> newMembers = List.from(allPotentialMembers);

    // 이미 밴드에 있는 멤버를 제외
    for (var member in allPotentialMembers) {
      for(var member2 in bandProvider.band.members){
        if (member.instrument.name==member2.instrument.name){
          newMembers.remove(member);
        }
      }
    }
    return newMembers;
  }

    // 초기 availableMembers 설정 예시
  void setavailableMember(BuildContext context) {
    final bandProvider = context.read<BandProvider>();
    availableMembers = _generateNewMembers(bandProvider);
  }


  void addMember(BuildContext context, Member member) {
    final bandProvider = context.read<BandProvider>();
    bandProvider.addMember(member);
    availableMembers.remove(member);
  }

  void addmembername(String name){
    membername.add(name);
  }

  // 주차 증가
  void incrementWeek() {
    if (currentWeek < 4) {
      currentWeek++;
    } else {
      currentWeek = 1;
      incrementMonth();
    }
  }

  // 월 증가
  void incrementMonth() {
    currentMonth++;
    isMonthComplete = false;

    if (currentMonth > 12) {
      currentMonth = 1;
      incrementYear();
    }
  }

  // 년도 증가
  void incrementYear() {
    currentYear++;
  }

  // 분기 계산
  int get currentQuarter {
    return ((currentMonth - 1) ~/ 3) + 1; // 1분기: 1~3월, 2분기: 4~6월 ...
  }

  // 분기 시작 확인
  bool isQuarterStart() {
    return currentMonth % 3 == 1; // 3, 6, 9, 12월일 때 분기 시작
  }

  // 주차 리셋
  void resetWeeklyCycle() {
    currentWeek = 1;
    isMonthComplete = false;
  }

  // 현재 상태 반환
  String getCurrentState() {
    return "년도: $currentYear, 분기: ${currentQuarter}분기, 월: $currentMonth, 주차: $currentWeek";
  }

  // 게임 종료 처리
  void endGame() {
    isGameOver = true;
  }
}
