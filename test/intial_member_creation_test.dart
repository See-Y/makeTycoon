import 'package:flutter_test/flutter_test.dart';
import 'package:make_tycoon/logic/member_creation_logic.dart';

void main() {
  test('유효한 악기로 멤버 생성', () {
    final member = MemberCreationLogic.createMember("보컬");

    expect(member.instrument, equals("보컬"));
    expect(member.name.isNotEmpty, isTrue);
    print("생성된 멤버: ${member.name}");
  });

  test('유효하지 않은 악기로 예외 발생', () {
    expect(() => MemberCreationLogic.createMember("트럼펫"), throwsException);
  });
}
