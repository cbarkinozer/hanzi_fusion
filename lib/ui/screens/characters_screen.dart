// lib/ui/screens/characters_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/providers/level_provider.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';

class CharactersScreen extends ConsumerWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levels = ref.watch(levelsProvider);
    final gameData = ref.watch(gameDataRepositoryProvider).value;
    final progress = ref.watch(playerProgressProvider).value;

    if (gameData == null || progress == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: levels.length,
      itemBuilder: (context, index) {
        final level = levels[index];
        final discoveredInLevel = level.characterIds
            .where((id) => progress.discoveredCharacterIds.contains(id))
            .length;
        final totalInLevel = level.characterIds.length;

        return ExpansionTile(
          title: Text('${level.name} ($discoveredInLevel / $totalInLevel)'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: level.characterIds.map((id) {
                  final character = gameData.characterMapById[id];
                  if (character == null) return const SizedBox.shrink();
                  final isDiscovered =
                      progress.discoveredCharacterIds.contains(id);
                  return _buildCharacterTile(context, character, isDiscovered);
                }).toList(),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildCharacterTile(
      BuildContext context, GameCharacter character, bool isDiscovered) {
    return InkWell(
      onTap: isDiscovered
          ? () => _showCharacterDetails(context, character)
          : null,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: isDiscovered
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            isDiscovered ? character.char : '?',
            style: TextStyle(
              fontSize: 32,
              color: isDiscovered
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(128),
            ),
          ),
        ),
      ),
    );
  }

  void _showCharacterDetails(BuildContext context, GameCharacter character) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          character.char,
          style: const TextStyle(fontSize: 48),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              character.pinyin,
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              character.meaning,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}