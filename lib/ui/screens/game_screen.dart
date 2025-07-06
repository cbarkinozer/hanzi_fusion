// FILE: lib/ui/screens/game_screen.dart

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_fusion/game/hanzi_fusion_game.dart';
import 'package:hanzi_fusion/ui/widgets/inventory_panel.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hanzi Fusion'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // The top 2/3 of the screen is the Flame game canvas (Fusion Area).
          Expanded(
            flex: 2,
            child: GameWidget(game: HanziFusionGame()),
          ),
          // The bottom 1/3 is the player's inventory.
          const Expanded(
            flex: 1,
            child: InventoryPanel(),
          ),
        ],
      ),
    );
  }
}