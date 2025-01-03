class GameManager {
  int money = 1000; // 초기 자금
  int fans = 0; // 초기 팬 수
  final List<String> members = []; // 초기 멤버 리스트

  void addMember(String member) {
    members.add(member);
  }

  void updateMoney(int amount) {
    money += amount;
  }

  void updateFans(int amount) {
    fans += amount;
  }

  @override
  String toString() {
    return 'Money: $money, Fans: $fans, Members: $members';
  }
}
