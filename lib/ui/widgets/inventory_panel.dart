// FILE: lib/ui/widgets/inventory_panel.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';

class InventoryPanel extends ConsumerWidget {
  const InventoryPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch both providers: one for game data, one for player progress
    final gameData = ref.watch(gameDataRepositoryProvider).valueOrNull;
    final discoveredIds = ref.watch(playerProgressProvider).valueOrNull;

    // Show a loading indicator if either provider is not ready
    if (gameData == null || discoveredIds == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Map the discovered IDs to actual GameCharacter objects
    final discoveredCharacters = discoveredIds
        .map((id) => gameData.characterMap[id])
        .where((char) => char != null)
        .toList();

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
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
          // For now, we just display the character in a box.
          // This will become a draggable component later.
          return Card(
            child: Center(
              child: Text(
                character.char,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          );
        },
      ),
    );
  }
}