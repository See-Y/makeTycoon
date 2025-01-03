import 'package:flutter/material.dart';
import 'ui/main_menu.dart';

void main() {
  runApp(const BandSimulationApp());
}

class BandSimulationApp extends StatelessWidget {
  const BandSimulationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
    );
  }
}
