// FILE: lib/ui/widgets/inventory_panel.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';

class InventoryPanel extends ConsumerWidget {
  const InventoryPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameData = ref.watch(gameDataRepositoryProvider).valueOrNull;
    // 'progress' is now a PlayerProgressData object, or null
    final progress = ref.watch(playerProgressProvider).valueOrNull;

    if (gameData == null || progress == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // --- FIX IS HERE ---
    // We now access the `discoveredCharacterIds` property from the `progress` object
    final discoveredCharacters = progress.discoveredCharacterIds
        .map((id) => gameData.characterMapById[id])
        .where((char) => char != null)
        .toList();
    // --- END OF FIX ---

    // Sort characters by their ID for a consistent order
    discoveredCharacters.sort((a, b) => a!.id.compareTo(b!.id));

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
          
          final characterTile = Card(
            child: Center(
              child: Text(
                character.char,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          );

          return Draggable<GameCharacter>(
            data: character,
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