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

    print("recruit build checked");
    return Scaffold(
      appBar: AppBar(title: const Text("신규 멤버 영입"),
        automaticallyImplyLeading: false,),
      body: Consumer<BandProvider>(
        builder: (context, bandProvider, child) {
          return ListView.builder(
            itemCount: availableMembers.length,
            itemBuilder: (context, index) {
              final member = availableMembers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 멤버 사진
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            member.image ?? 'assets/images/갈매기.png', // 기본 이미지 경로
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 16),
                        // 멤버 정보
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text('동물: ${member.animalType}'),
                              Text('포지션: ${member.instrument.name}'),
                              Text('MBTI: ${mbti(member)}'),
                            ],
                          ),
                        ),
                        // 영입 버튼
                        Column(
                          children:[
                            ElevatedButton(
                              onPressed: () {
                                GameManager().addMember(context, member);
                                bandProvider.updateMoney(-50);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('영입'),
                            ),
                            Text('50만 원'),
                          ]
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String mbti(Member member) {
    return [
      member.mbti[0] >= 0 ? 'E' : 'I',
      member.mbti[1] >= 0 ? 'N' : 'S',
      member.mbti[2] >= 0 ? 'F' : 'T',
      member.mbti[3] >= 0 ? 'P' : 'J',
    ].join('');
  }

}