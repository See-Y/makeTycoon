import 'dart:math';
import 'package:flutter/material.dart';
import '../../game_manager.dart';
import '../../logic/monthly_data_manager.dart';
import '../../widget/global_wrapper.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';
import '../../models/band.dart';
import '../../models/member.dart';
import '../../models/event.dart';


class RandomEventScreen extends StatefulWidget {
  final List<Member> members;
  const RandomEventScreen({Key? key, required this.members}) : super(key: key);

  @override
  _RandomEventScreenState createState() => _RandomEventScreenState();
}

class _RandomEventScreenState extends State<RandomEventScreen> {
  Event? currentEvent;
  String resultMessage = '';

  @override
  void initState() {
    super.initState();
    _triggerRandomEvent();
  }

  // 랜덤 이벤트를 발생시키는 메서드
  void _triggerRandomEvent() {
    Random random = Random();
    int event = random.nextInt(3);  // 0, 1, 2의 값으로 랜덤 선택

    switch (event) {
      case 0:
      // 번지점프 할 사람 고르기
        currentEvent=_bungeeJump();
        break;
      case 1:
      // 입합주를 하다가 보컬이 목이 상함
        currentEvent=_mouthHapju();
        break;
      case 2:
      // 멤버가 실수로 공연을 망친다
        currentEvent=_rehearsal();
        break;
      default:
        break;
    }
  }

  // 번지점프 이벤트 -> 유저에게 선택지 제공
  Event _bungeeJump() {
    Member member1 = widget.members[Random().nextInt(widget.members.length)];
    Member member2 = widget.members[Random().nextInt(widget.members.length)];

    while (member1 == member2) {
      member2 = widget.members[Random().nextInt(widget.members.length)];
    }

    return Event(
      name: "번지점프",
      description: "우리 밴드가 익스트림 예능에 출연했습니다.\n멤버 한 명이 반드시 번지점프를 해야 한다면,\n누구를 시키시겠습니까?",
      imagePath: 'assets/images/번지점프.jpg',
      choices: ["${member1.name}", "${member2.name}"],
      resolveEvent: (choiceIndex) {
        if (choiceIndex == 0) {
          for (var member in widget.members) {
            if (member != member1) {  // 본인은 제외
              if(member.mbti[1]>=0) { //양수이면 N임, N이면 고마워서 지지율 높아짐.
                member.approvalRatings.update(
                  member1,
                      (value) => (value + 1).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => 1, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
              else {
                member.approvalRatings.update(
                  member1,
                      (value) => (value - 1).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => -1, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
            }
          }
        } else {
          for (var member in widget.members) {
            if (member != member2) {  // 본인은 제외
              if(member.mbti[1]>=0) { //양수이면 N임, N이면 고마워서 지지율 높아짐.
                member.approvalRatings.update(
                  member2,
                      (value) => (value + 1).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => 1, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
              else {
                member.approvalRatings.update(
                  member2,
                      (value) => (value - 1).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => -1, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
            }
          }
        }
        setState(() {
          resultMessage = "${choiceIndex == 0 ? member1.name : member2.name}의 편을 들었습니다.";
        });
      },
    );
  }

  Event _mouthHapju() {
    Member member1 = widget.members[Random().nextInt(widget.members.length)];
    Member member2 = widget.members[Random().nextInt(widget.members.length)];

    while (member1 == member2) {
      member2 = widget.members[Random().nextInt(widget.members.length)];
    }

    return Event(
      name: "입합주",
      description: "밴드가 입 합주를 하다가 보컬이 노래를\n못 하게 됐습니다.\n누구의 탓입니까?",
      imagePath: 'assets/images/입합주.png',
      choices: ["${member1.name}", "${member2.name}"],
      resolveEvent: (choiceIndex) {
        if (choiceIndex == 0) {
          for (var member in widget.members) {
            if (member != member1) {  // 본인은 제외
              if(member.mbti[3]>=0) { //양수이면 P임 그럴 수도 있으니 그냥 넘어간다.
                continue;
              }
              else {
                member.approvalRatings.update(
                  member1,
                      (value) => (value - 2).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => -2, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
            }
          }
        } else {
          for (var member in widget.members) {
            if (member != member2) {  // 본인은 제외
              if(member.mbti[3]>=0) { //양수이면 P임 그럴 수도 있으니 그냥 넘어간다.
                continue;
              }
              else {
                member.approvalRatings.update(
                  member2,
                      (value) => (value - 2).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => -2, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
            }
          }
        }
        setState(() {
          resultMessage = "${choiceIndex == 0 ? member1.name : member2.name}이 잘못했다고 말합니다.";
        });
      },
    );
  }

  Event _rehearsal() {
    Member member1 = widget.members[Random().nextInt(widget.members.length)];
    Member member2 = widget.members[Random().nextInt(widget.members.length)];

    while (member1 == member2) {
      member2 = widget.members[Random().nextInt(widget.members.length)];
    }

    return Event(
      name: "리허설",
      description: "오늘 우리 밴드가 리허설에서\n큰 실수를 했습니다.\n누구에게 병샷을 시킬까요?",
      imagePath: 'assets/images/병샷.png',
      choices: ["${member1.name}", "${member2.name}"],
      resolveEvent: (choiceIndex) {
        if (choiceIndex == 0) {
          for (var member in widget.members) {
            if (member != member1) {  // 본인은 제외
              if(member.mbti[2]>=0) { //양수이면 F임, F면 부당하다고 생각해서 지지율 낮아짐.
                member.approvalRatings.update(
                  member1,
                      (value) => (value - 3).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => -3, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
              else { //T는 그냥 내 알 빠 아니다, 꼬시다 고 생각해서 지지율 높아짐.
                member.approvalRatings.update(
                  member1,
                      (value) => (value + 1).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => 1, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
            }
          }
        } else {
          for (var member in widget.members) {
            if (member != member2) {  // 본인은 제외
              if(member.mbti[2]>=0) { //양수이면 F임, F면 부당하다고 생각해서 지지율 낮아짐.
                member.approvalRatings.update(
                  member2,
                      (value) => (value - 3).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => -3, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
              else {
                member.approvalRatings.update(
                  member2,
                      (value) => (value + 1).clamp(-10, 10),
                  // 범위를 -10 ~ 10으로 제한
                  ifAbsent: () => 1, // 처음 지지율이 없으면 change 값으로 설정
                );
              }
            }
          }
        }
        setState(() {
          resultMessage = "${choiceIndex == 0 ? member1.name : member2.name}에게 병샷을 시킵니다.";
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    if (currentEvent == null) {
      return const CircularProgressIndicator();
    }
    return Scaffold(
      appBar: AppBar(title: const Text("돌발 상황 발생!"), automaticallyImplyLeading: false,),
      body: Center(
        //padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentEvent!.description,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(currentEvent!.imagePath, width: MediaQuery.of(context).size.width * 0.75),
            const SizedBox(height: 20),
              Column(
                children: List.generate(currentEvent!.choices.length * 2 - 1, (index) {
                  if (index.isOdd) {
                    return SizedBox(height: 10);  // 버튼 사이에 간격
                  }
                  final choiceIndex = index ~/ 2;
                  return _buildCustomButton(context, currentEvent!.choices[choiceIndex], () {
                    currentEvent!.resolveEvent(choiceIndex);
                    setState(() {});
                    _onActivityComplete(context);
                  });
                }),
              ),
          ],
        ),
      ),
    );
  }
  void _onActivityComplete(BuildContext context) {
    final gameManager = GameManager();
    if (gameManager.currentWeek < 4) {
      // 다음 주차로 진행
      gameManager.incrementWeek();
      _navigateToNextWeek(context);
    } else {
      // 월간 주기 종료
      gameManager.incrementWeek();
      //MonthlyDataManager().resetMonthlyData(); // 활동 데이터 초기화
      Navigator.pushNamed(context, '/monthly-summary');
    }
  }
  void _navigateToNextWeek(BuildContext context) {
    final manager = MonthlyDataManager();
    final nextWeekActivity = manager.getWeeklyActivity(GameManager().currentWeek - 1)?.activityType;

    if (nextWeekActivity == "공연") {
      Navigator.pushNamed(context, '/week-performance');
    } else if (nextWeekActivity == "음반 작업") {
      Navigator.pushNamed(context, '/week-album');
    } else if (nextWeekActivity == "휴식") {
      Navigator.pushNamed(context, '/week-rest');
    }
  }

  Widget _buildCustomButton(BuildContext context, String label, VoidCallback onPressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5, // 화면의 3/4 너비
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10), // 버튼 높이
          decoration: BoxDecoration(
            color: Colors.black, // 버튼 배경 색상
            borderRadius: BorderRadius.circular(25), // 둥근 직사각형
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // 그림자 색상
                offset: Offset(0, 5), // 그림자 위치 (X, Y)
                blurRadius: 10, // 그림자 흐림 정도
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,   // 텍스트 색상
                fontSize: 17,          // 폰트 크기
                fontWeight: FontWeight.bold, // 폰트 두께
                fontFamily: 'DungGeunMo',  // 폰트 패밀리
              ),
            ),
          ),
        ),
      ),
    );
  }
}
