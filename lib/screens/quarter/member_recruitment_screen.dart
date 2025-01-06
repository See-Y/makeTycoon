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
      appBar: AppBar(title: const Text("신규 멤버 영입")),
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
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: member.image != null
                                  ? FileImage(File(member.image!))
                                  : AssetImage('assets/placeholder.png') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
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
                              Text('악기: ${member.instrument}'),
                              Text('MBTI: ${member.mbti}'),
                            ],
                          ),
                        ),
                        // 영입 버튼
                        ElevatedButton(
                          onPressed: () {
                            GameManager().addMember(context, member);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text('영입'),
                        ),
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
}