import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchBandData() async {
  final url = Uri.parse('https://bandtycoonserver.onrender.com/api/bands');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    print("Fetch band data success!!:$data");
    return data.cast<Map<String, dynamic>>();
  } else {
    print('Failed to fetch band data: ${response.body}');
    return [];
  }
}
