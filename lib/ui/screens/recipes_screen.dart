// lib/ui/screens/recipes_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';

class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameData = ref.watch(gameDataRepositoryProvider).value;
    final progress = ref.watch(playerProgressProvider).value;

    if (gameData == null || progress == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final discoveredRecipes = progress.discoveredRecipeKeys.map((key) {
      return gameData.recipeMapByKey[key];
    }).where((recipe) => recipe != null).toList();

    if (discoveredRecipes.isEmpty) {
      return const Center(
        child: Text(
          'No recipes discovered yet. \nCombine characters in the game!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: discoveredRecipes.length,
      itemBuilder: (context, index) {
        final recipe = discoveredRecipes[index]!;
        final input1 = gameData.characterMapById[recipe.inputIds[0]];
        final input2 = gameData.characterMapById[recipe.inputIds[1]];
        final output = gameData.characterMapById[recipe.outputId];

        if (input1 == null || input2 == null || output == null) {
          return const SizedBox.shrink();
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(input1.char, style: const TextStyle(fontSize: 24)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.add),
                ),
                Text(input2.char, style: const TextStyle(fontSize: 24)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.arrow_forward),
                ),
                Text(output.char, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }
}