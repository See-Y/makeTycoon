import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:make_tycoon/models/member.dart';

Future<void> saveBandData(String token, int fanCount, int money, String leaderName, List<Member> members) async {
  final url = Uri.parse('https://bandtycoonserver.onrender.com/api/bands');

  List<Map<String, dynamic>> memberData = members.map((member) {
    return {
      'name': member.name,
      'instrument': member.instrument.name.toString(),
      'level': member.level,
    };
  }).toList();

  try {
    print('Sending POST request...');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': token,
        'fan_count': fanCount,
        'money': money,
        'leader_name': leaderName,
        'members': memberData,
      }),
    );

    print('Response received!');
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      print('Band data saved successfully');
    } else {
      print('Failed to save band data: ${response.body}');
    }
  } catch (e) {
    print('Error occurred while sending POST request: $e');
  }
}
