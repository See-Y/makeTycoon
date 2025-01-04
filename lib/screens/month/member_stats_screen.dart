import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart'; // band_provider 경로 맞추기


class MemberStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // BandProvider에서 밴드 데이터 가져오기
    final band = Provider.of<BandProvider>(context).band;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('멤버 둘러보기'),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Column(
          children: [
            // 멤버 슬라이드를 보여줄 부분
            SizedBox(
              height: 150, // 세로 길이를 짧게 설정
              child: PageView.builder(
                itemCount: band.members.length,
                itemBuilder: (context, index) {
                  final member = band.members[index];
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8, // 화면 가로보다 좁은 크기
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // 왼쪽에 멤버 사진
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 40,
                                //backgroundImage: AssetImage(member.avatar), // 멤버의 아바타 이미지
                              ),
                            ),
                            // 오른쪽에 이름과 정보
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.name,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text('MBTI: ${member.mbti}'),
                                //Text('Level: ${member.level}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 레벨업 버튼
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 레벨업 기능 구현
                final member = band.members[0]; // 예시로 첫 번째 멤버 레벨업
                // bandProvider에 업데이트를 반영
                //Provider.of<BandProvider>(context, listen: false).updateBand(band);
              },
              child: const Text('레벨업하기'),
            ),
          ],
        ),
      ),
    );
  }
}