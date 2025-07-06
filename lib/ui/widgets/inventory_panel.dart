// FILE: lib/ui/widgets/inventory_panel.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/models/character_model.dart'; // Import model
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';

class InventoryPanel extends ConsumerWidget {
  const InventoryPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameData = ref.watch(gameDataRepositoryProvider).valueOrNull;
    final discoveredIds = ref.watch(playerProgressProvider).valueOrNull;

    if (gameData == null || discoveredIds == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final discoveredCharacters = discoveredIds
        .map((id) => gameData.characterMapById[id])
        .where((char) => char != null)
        .toList();

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 80,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: discoveredCharacters.length,
        itemBuilder: (context, index) {
          final character = discoveredCharacters[index]!;
          
          // The character tile in the inventory.
          final characterTile = Card(
            child: Center(
              child: Text(
                character.char,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          );

          // Wrap the tile in a Draggable widget.
          // The generic type <GameCharacter> is important!
          return Draggable<GameCharacter>(
            data: character,
            // This is the widget that appears under the user's finger during drag.
            feedback: SizedBox(
              width: 80,
              height: 80,
              child: Opacity(opacity: 0.8, child: characterTile),
            ),
            child: characterTile,
          );
        },
      ),
    );
  }
}