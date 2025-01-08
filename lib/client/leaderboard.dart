import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

Future<List<Map<String, dynamic>>?> fetchLeaderboard() async {
  final url = Uri.parse('https://bandtycoonserver.onrender.com/api/leaderboard');
  final Logger logger = Logger();

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      logger.i('Leaderboard data fetched successfully');
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      print('Failed to fetch leaderboard: ${response.body}');
      return null;
    }
  } catch (e) {
    logger.e('Error occurred while fetching leaderboard: $e');
    return null;
  }
}
