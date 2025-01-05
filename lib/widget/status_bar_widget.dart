import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/band_provider.dart';

// 맨 위쪽에 뜨는 밴드 이름, 돈, 팬 표시하는 위젯 분리
class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bandProvider = Provider.of<BandProvider>(context);
    final money = bandProvider.band.money;
    final fans = bandProvider.band.fans;
    final name = bandProvider.band.name;

    return Container(
      color: Colors.black, // StatusBar 배경 색상
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '돈: $money만 원',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '팬: $fans명',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
