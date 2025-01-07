import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../client/leaderboard.dart'; // fetchLeaderboard() 함수가 정의된 파일

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late Future<List<Map<String, dynamic>>?> leaderboardFuture;

  @override
  void initState() {
    super.initState();
    leaderboardFuture = fetchLeaderboard(); // 비동기 데이터 가져오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: leaderboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터 로드 중
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // 에러 발생
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // 데이터 없음
            return Center(
              child: Text(
                'No leaderboard data available.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          // 데이터 로드 완료
          final leaderboardData = snapshot.data!;

          return ListView.builder(
            itemCount: leaderboardData.length,
            itemBuilder: (context, index) {
              final band = leaderboardData[index];

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        band['band_name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Leader: ${band['leader_name']}',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Text(
                        'Fans: ${band['fans']}',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Text(
                        'Money: \$${band['money']}',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Members:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (band['members'] as List<dynamic>).map((member) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              '- ${member['name']} (Level: ${member['level']})',
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
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
