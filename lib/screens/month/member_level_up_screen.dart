import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/member.dart';
import '../../widget/global_wrapper.dart';
import '../../providers/band_provider.dart';

class MemberLevelUpScreen extends StatefulWidget {
  final Member member;

  const MemberLevelUpScreen({super.key, required this.member});

  @override
  State<MemberLevelUpScreen> createState() => _MemberLevelUpScreenState();
}

class _MemberLevelUpScreenState extends State<MemberLevelUpScreen> {
  late List<int> stats;
  int remainingPoints = 5;

  @override
  void initState() {
    super.initState();
    stats = List<int>.from(widget.member.stats);
  }

  void _incrementStat(int index) {
    if (remainingPoints > 0) {
      setState(() {
        stats[index]++;
        remainingPoints--;
      });
    }
  }

  void _decrementStat(int index) {
    if (stats[index] > widget.member.stats[index]) {
      setState(() {
        stats[index]--;
        remainingPoints++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final member = widget.member;
    final bandProvider = Provider.of<BandProvider>(context, listen: false);
    final statsNames = ["관종", "똘끼", "깡", "스껄"];

    return GlobalWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("레벨업"),
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "레벨업!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'DungGeunMo'),
            ),
            const SizedBox(height: 16),
            Text(
              member.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            ...List.generate(stats.length, (index) {
              return Row(
                children: [
                  SizedBox(width: 60, child: Text(statsNames[index])),
                  IconButton(
                    onPressed: () => _decrementStat(index),
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: stats[index] / 50.0,
                      color: Colors.blue,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _incrementStat(index),
                    icon: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 8),
                  Text("${stats[index]}"),
                ],
              );
            }),
            const SizedBox(height: 16),
            Text("남은 포인트: $remainingPoints", style: const TextStyle(fontFamily: 'DungGeunMo'),),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: remainingPoints == 0
                  ? () {
                // 스탯 업데이트 및 레벨 증가
                bandProvider.updateMemberStats(member, stats);
                bandProvider.incrementMemberLevel(member);

                // 이전 화면으로 복귀
                Navigator.pop(context);
              }
                  : null,
              child: const Text("확인", style: const TextStyle(fontFamily: 'DungGeunMo')),
            ),
          ],
        ),
      ),
    );
  }
}
