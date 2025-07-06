// FILE: lib/ui/screens/game_screen.dart

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/game/hanzi_fusion_game.dart';
import 'package:hanzi_fusion/ui/widgets/inventory_panel.dart';

// Convert to a ConsumerStatefulWidget to hold the game instance and access ref.
class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  // Create a single, persistent instance of our game.
  late final HanziFusionGame _game;

  @override
  void initState() {
    super.initState();
    // Pass the Riverpod ref to the game so it can interact with providers.
    _game = HanziFusionGame(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hanzi Fusion'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            // The DragTarget wraps the GameWidget. This is the correct pattern.
            child: DragTarget<GameCharacter>(
              // This is called when a draggable from the inventory is dropped here.
              onAcceptWithDetails: (details) {
                // We call our public method on the game instance,
                // passing the data and the screen position of the drop.
                _game.addCharacterFromDrop(details.data, details.offset);
              },
              builder: (context, candidateData, rejectedData) {
                // The GameWidget is the child, displaying our game instance.
                return GameWidget(game: _game);
              },
            ),
          ),
          const Expanded(
            flex: 1,
            child: InventoryPanel(),
          ),
        ],
      ),
    );
  }
}