class Venue {
  final String name;
  final int fee;
  final int fanIncrease;
  final int maxAudience;
  final double idealPrice; // 적정 티켓 가격
  final String description;

  Venue({
    required this.name,
    required this.fee,
    required this.fanIncrease,
    required this.maxAudience,
    required this.idealPrice,
    required this.description,
  });
}
