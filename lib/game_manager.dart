import 'dart:math';
import 'models/member.dart';
import 'logic/member_creation_logic.dart';

class GameManager {
  static final GameManager _instance = GameManager._internal();

  factory GameManager() => _instance;

  GameManager._internal();

  // 밴드 구성
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

  // 현재 밴드 상태 출력 (디버깅용)
  void printBandStatus() {
    print("=== 밴드 멤버 ===");
    for (var member in bandMembers) {
      print(
          "이름: ${member.name}, 동물: ${member.animalType}, 악기: ${member.instrument}");
    }
  }
}
