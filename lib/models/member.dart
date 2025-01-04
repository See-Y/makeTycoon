class Member {
  final String name;
  final String animalType;
  final String instrument;
  final List<int> stats; // [관종, 똘끼, 깡, 스껄]
  final List<int> mbti; // [-100 ~ 100 벡터]
  final Map<Member, int> supportRatings; // 다른 멤버에 대한 지지율
  int approvalRating;

  Member({
    required this.name,
    required this.animalType,
    required this.instrument,
    required this.stats,
    required this.mbti,
    this.approvalRating = 0,
  }) : supportRatings = {};

  double calculateAverageSupport(List<Member> allMembers) {
    final ratingsTowardsMe = allMembers
        .where((member) => member.supportRatings.containsKey(this))
        .map((member) => member.supportRatings[this]!)
        .toList();

    if (ratingsTowardsMe.isEmpty) return 0.0;

    final totalSupport = ratingsTowardsMe.reduce((a, b) => a + b);
    return totalSupport / ratingsTowardsMe.length;
  }
}
