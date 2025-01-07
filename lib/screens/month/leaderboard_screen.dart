import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../client/band_recieve.dart';
import '../../client/user_data_send.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late Future<List<dynamic>> leaderboard;

  final ScrollController _controller = ScrollController();

  void _scrollToPosition(int index) {
    final double position = index * 100.0; // 리스트 아이템 높이에 맞춤
    _controller.animateTo(
      position,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchBandData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No band data available');
        } else {
          final bands = snapshot.data!;
          return ListView.builder(
            itemCount: bands.length,
            itemBuilder: (context, index) {
              final band = bands[index];
              return ListTile(
                title: Text('${band['leader_name']} (${band['fan_count']} fans)'),
                subtitle: Text('Money: ${band['money']}'),
              );
            },
          );
        }
      },
    );
  }

}
