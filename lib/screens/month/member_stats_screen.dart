import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/band.dart';
import '../../providers/band_provider.dart';
import '../../models/member.dart';
import '../../data/member_level_data.dart';

class MemberStatsScreen extends StatelessWidget {
  const MemberStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bandProvider = Provider.of<BandProvider>(context);
    final band = bandProvider.band;

    return Scaffold(
      appBar: AppBar(
        title: const Text('멤버 둘러보기'),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      ),
      body: PageView.builder(
        itemCount: band.members.length,
        itemBuilder: (context, index) {
          final member = band.members[index];
          return MemberCard(member: member, bandProvider: bandProvider);
        },
      ),
    );
  }
}

class MemberCard extends StatefulWidget {
  final Member member;
  final BandProvider bandProvider;

  const MemberCard({
    super.key,
    required this.member,
    required this.bandProvider,
  });

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  bool showApproval = false;

  @override
  Widget build(BuildContext context) {
    final member = widget.member;
    final band = widget.bandProvider.band;
    final level = member.level;
    final nextLevelCost = memberLevelData[level];
    final mbti = [
      member.mbti[0] >= 0 ? 'E' : 'I',
      member.mbti[1] >= 0 ? 'N' : 'S',
      member.mbti[2] >= 0 ? 'F' : 'T',
      member.mbti[3] >= 0 ? 'P' : 'J',
    ].join('');
    final isLeader = member.isLeader;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이름 및 리더 여부
              Text(
                isLeader ? "리더: ${member.name}" : member.name,
                style: TextStyle(
                  fontWeight: isLeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 8),

              // 레벨 및 MBTI 표시
              Text("레벨: $level", style: const TextStyle(fontSize: 16)),
              Text("MBTI: $mbti", style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 8),

              // 스탯 막대 그래프
              _buildStatsBar(member),

              const SizedBox(height: 8),

              // 리더 효과
              Text(
                "리더 효과 1: ${member.leaderEffect1.description}",
                style: TextStyle(
                  fontWeight: isLeader ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                "리더 효과 2: ${member.leaderEffect2.description}",
                style: TextStyle(
                  fontWeight: isLeader ? FontWeight.bold : FontWeight.normal,
                ),
              ),

              const SizedBox(height: 8),

              // 지지율 표시
              GestureDetector(
                onTap: () {
                  setState(() {
                    showApproval = !showApproval;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("다른 멤버들의 나에 대한 지지율", style: TextStyle(fontSize: 16)),
                    Icon(showApproval ? Icons.expand_less : Icons.expand_more),
                  ],
                ),
              ),
              if (showApproval) _buildApprovalGraph(member, band),

              const Spacer(),

              // 레벨업 버튼
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (band.money < nextLevelCost) {
                      // 돈 부족 알림
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("돈이 부족합니다.")),
                      );
                    } else {
                      // 돈 차감 및 레벨업 페이지 이동
                      widget.bandProvider.updateMoney(band.money - nextLevelCost);
                      Navigator.pushNamed(
                        context,
                        '/level-up',
                        arguments: member,
                      );
                    }
                  },
                  child: Text("레벨업 비용: \$${nextLevelCost}"),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsBar(Member member) {
    final statsNames = ["관종", "똘끼", "깡", "스껄"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(member.stats.length, (index) {
        final statValue = member.stats[index];
        return Row(
          children: [
            SizedBox(width: 60, child: Text(statsNames[index])),
            Expanded(
              child: LinearProgressIndicator(
                value: statValue / 50.0, // 최대값 50 기준
                color: Colors.blue,
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(width: 8),
            Text("$statValue"),
          ],
        );
      }),
    );
  }

  Widget _buildApprovalGraph(Member member, Band band) {
    final approvalRatings = band.members
        .where((otherMember) => otherMember != member)
        .map((otherMember) {
      final approvalValue = otherMember.approvalRatings[member] ?? 0.0;
      return {
        'name': otherMember.name,
        'value': approvalValue,
      };
    }).toList();

    return Column(
      children: approvalRatings.map((entry) {
        final name = entry['name'] as String;
        final approvalValue = entry['value'] as int;
        return Row(
          children: [
            SizedBox(width: 80, child: Text(name)),
            Expanded(
              child: LinearProgressIndicator(
                value: (approvalValue + 10) / 20.0, // -10 ~ 10을 0 ~ 1로 변환
                color: approvalValue >= 0 ? Colors.green : Colors.red,
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(width: 8),
            Text("${approvalValue.toStringAsFixed(1)}"),
          ],
        );
      }).toList(),
    );
  }
}
