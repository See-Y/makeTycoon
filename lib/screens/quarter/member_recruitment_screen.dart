import 'package:flutter/material.dart';
import 'package:make_tycoon/game_manager.dart';
import 'package:make_tycoon/logic/member_creation_logic.dart';
import 'package:provider/provider.dart';
import '../../models/member.dart';  // 멤버 모델
import '../../providers/band_provider.dart';  // BandProvider
import '../../data/member_data.dart';
import '../../models/instrument.dart';
import 'dart:io';

class MemberRecruitmentScreen extends StatefulWidget {
  const MemberRecruitmentScreen({super.key});

  @override
  _MemberRecruitmentScreenState createState() => _MemberRecruitmentScreenState();
}

class _MemberRecruitmentScreenState extends State<MemberRecruitmentScreen> {
  List<Member> availableMembers = GameManager().availableMembers;

  @override
  void initState() {
    super.initState();
    // 밴드에 이미 있는 멤버를 제외한 신규 멤버들을 생성
  }


  @override
  Widget build(BuildContext context) {
    final bandProvider = Provider.of<BandProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text("신규 멤버 영입")),
      body: ListView.builder(
        itemCount: availableMembers.length,
        itemBuilder: (context, index) {
          final member = availableMembers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 2),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: member.image != null
                      ? Image.asset(
                    member.image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                      : Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                title: Text(member.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('동물: ${member.animalType}'),
                    Text('${member.instrument}'),
                    Text('MBTI: ${member.mbti}'),
                    Text('리더 패시브 효과 1: ${member.leaderEffect1.description}'),
                    Text('리더 패시브 효과 2: ${member.leaderEffect2.description}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // 밴드에 멤버 추가
                    GameManager().addMember(context, member);
                    // 추가 후 화면 전환 또는 성공 메시지 표시
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}