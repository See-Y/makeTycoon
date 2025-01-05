class Album {
  final String name;
  final DateTime releaseDate;
  final int fanBoost; // 발매 즉시 팬 증가
  final int monthlyIncome; // 월별 고정 수입
  String? albumArt; //앨범아트 경로

  Album({
    required this.name,
    required this.releaseDate,
    this.fanBoost = 0,
    this.monthlyIncome = 0,
    this.albumArt,
  });
}
