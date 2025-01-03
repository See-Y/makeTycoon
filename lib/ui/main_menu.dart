import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/band_simulation_game.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Band Simulation"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GameWidget(game: BandSimulationGame()),
            ));
          },
          child: const Text("Start Game"),
        ),
      ),
    );
  }
}
