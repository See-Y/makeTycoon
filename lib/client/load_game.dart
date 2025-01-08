import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:make_tycoon/logic/load_game_logic.dart';

void loadBandData(
  String? token,
  String? guestId,
  BuildContext context
) async {
  final url = Uri.parse(
      'https://bandtycoonserver.onrender.com/api/bands/load?token=$token&guest_id=$guestId');
  final Logger logger = Logger();
  logger.i('Band $guestId');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      logger.i('Band data loaded successfully');
      applyLoadedData(context, Map<String, dynamic>.from(jsonDecode(response.body))) ;
    } else {
      logger.e('Failed to load band data: ${response.body}');
      return;
    }
  } catch (e) {
    logger.e('Error occurred while loading band data: $e');
    return;
  }
}
