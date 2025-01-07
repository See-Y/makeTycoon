import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../logic/user_manager.dart';
import '../models/member.dart';

Future<void> saveBandData(
  String? token,
  String bandName,
  int fanCount,
  int money,
  int currentYear,
  int currentMonth,
  int currentWeek,
  List<Member> members,
) async {
  final url = Uri.parse('https://bandtycoonserver.onrender.com/api/bands');
  final Logger logger = Logger();
  final String guestId = await UserManager.getOrCreateGuestId();

  // 유저 ID 결정 (Google ID Token 또는 익명 ID)
  final String userId = token ?? guestId;

  // 멤버 데이터를 맵 형태로 변환
  List<Map<String, dynamic>> memberData = members.map((member) {
    return {
      'name': member.name,
      'instrument': {
        'name': member.instrument.name,
        'rarity': member.instrument.rarity,
        'effects': member.instrument.effects,
      },
      'level': member.level,
      'stats': member.stats,
      'mbti': member.mbti,
      'approvalRatings': member.approvalRatings.map((key, value) => MapEntry(key.name, value)), // 수정된 부분
      'isLeader': member.isLeader, // 추가된 부분
    };
  }).toList();

  try {
    // 서버로 POST 요청 전송
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': token,
        'guest_id': token == null ? userId : null,
        'name': bandName,
        'fans': fanCount,
        'money': money,
        'currentYear': currentYear,
        'currentMonth': currentMonth,
        'currentWeek': currentWeek,
        'members': memberData,
      }),
    );

    if (response.statusCode == 200) {
      logger.i('Band data saved successfully');
    } else {
      logger.e('Failed to save band data: ${response.body}');
    }
  } catch (e) {
    logger.e('Error occurred while sending POST request: $e');
  }
}
