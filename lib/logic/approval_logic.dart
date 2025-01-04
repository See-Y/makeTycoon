import 'dart:math';
import '../models/member.dart';

class ApprovalLogic {
  static const int minApproval = -10; // 최소 지지율
  static const int maxApproval = 10; // 최대 지지율

  /// 멤버 간의 초기 지지율 설정
  static void initializeApprovalRatings(List<Member> members) {
    final leader = members.first;
    for (var member in members) {
      for (var other in members) {
        if (member == leader && other == leader) {
          member.approvalRatings[other] = 5; // 리더 자신의 지지율
        } else if (member == leader) {
          member.approvalRatings[other] = 0; // 리더는 다른 멤버를 특별히 신경쓰지 않음
        } else if (other == leader) {
          member.approvalRatings[other] = 5; // 모두 리더에게 기본 지지율 5
        } else if (member == other) {
          member.approvalRatings[other] = 0; // 자기 자신에 대한 지지율 0
        } else {
          member.approvalRatings[other] = Random().nextInt(6) as double; // 0~5 랜덤 지지율
        }
      }
    }
  }

  /// 새로운 멤버 추가 시 지지율 설정
  static void addApprovalForNewMember(Member newMember, List<Member> existingMembers) {
    for (var member in existingMembers) {
      // 기존 멤버가 새 멤버를 향한 지지율
      member.approvalRatings[newMember] = Random().nextInt(5) - 2; // -2 ~ 2 랜덤

      // 새 멤버가 기존 멤버를 향한 지지율 (평균값)
      final averageApproval = member.approvalRatings.values
          .where((value) => value != null)
          .reduce((a, b) => a + b) ~/
          member.approvalRatings.length;
      newMember.approvalRatings[member] = averageApproval.toDouble();
    }

    // 새 멤버 자신에 대한 지지율
    newMember.approvalRatings[newMember] = 0;
  }

  /// 멤버 제거 시 지지율 항목 삭제
  static void removeApprovalForMember(Member removedMember, List<Member> remainingMembers) {
    for (var member in remainingMembers) {
      member.approvalRatings.remove(removedMember); // 나가는 멤버 제거
    }
  }
}
