// lib/ui/screens/game_page.dart
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/game/hanzi_fusion_game.dart';
import 'package:hanzi_fusion/ui/widgets/inventory_panel.dart';

class GamePage extends StatelessWidget {
  final HanziFusionGame game;

  const GamePage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: DragTarget<GameCharacter>(
            onAcceptWithDetails: (details) {
              game.addCharacterFromDrop(details.data, details.offset);
            },
            builder: (context, candidateData, rejectedData) {
              return GameWidget(game: game);
            },
          ),
        ),
        const Expanded(
          flex: 1,
          child: InventoryPanel(),
        ),
      ],
    );
  }
}