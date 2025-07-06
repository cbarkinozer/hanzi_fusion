// FILE: lib/game/hanzi_fusion_game.dart

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/data/models/recipe_model.dart';
import 'package:hanzi_fusion/game/components/character_component.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';

class HanziFusionGame extends FlameGame with HasCollisionDetection {
  final WidgetRef ref;
  HanziFusionGame({required this.ref});

  @override
  Color backgroundColor() => const Color(0xFF202020);

  @override
  Future<void> onLoad() async {
    // Debug mode is great for seeing hitboxes.
    debugMode = true;

    // TODO: Pre-load your audio files here for better performance
    // await FlameAudio.audioCache.loadAll(['success.wav', 'fail.wav']);
  }

  /// This is a public method for the UI to call.
  /// It takes a screen position (Offset) and handles the conversion.
  void addCharacterFromDrop(GameCharacter character, Offset screenPosition) {
    // Check if a component with this character ID already exists on the canvas
    final alreadyExists = world.children
        .whereType<CharacterComponent>()
        .any((component) => component.character.id == character.id);

    if (alreadyExists) {
      // TODO: Play a "cannot add" sound or show a small visual cue.
      print("Character already on screen!");
      return;
    }

    // Convert the screen tap position to the game's world position
    final worldPosition =
        camera.globalToLocal(Vector2(screenPosition.dx, screenPosition.dy));

    // Create and add the component to the game world
    final component = CharacterComponent(
      character: character,
      position: worldPosition,
    );
    world.add(component);
  }

  /// Checks if two characters can be fused and handles the result.
  void checkForFusion(CharacterComponent first, CharacterComponent second) {
    final gameData = ref.read(gameDataRepositoryProvider).value;
    if (gameData == null) return; // Data not loaded yet

    // Create a sorted list of the input IDs to match the recipe format
    final inputIds = [first.character.id, second.character.id]..sort();

    // Find a matching recipe
    final recipe = gameData.recipes.cast<Recipe?>().firstWhere(
          (r) =>
              r != null &&
              r.inputIds.length == 2 && // Ensure it's a 2-ingredient recipe
              r.inputIds[0] == inputIds[0] &&
              r.inputIds[1] == inputIds[1],
          orElse: () => null,
        );

    if (recipe != null) {
      // FUSION SUCCESS!
      final outputCharacter = gameData.characterMap[recipe.outputId];
      if (outputCharacter != null) {
        // 1. Calculate the position for the new character (midpoint of the two)
        final fusionPosition = (first.position + second.position) / 2;

        // 2. Remove the two input characters
        world.remove(first);
        world.remove(second);

        // 3. Add the new character component to the game
        // We convert the world position back to an offset for the existing method
        addCharacterFromDrop(
            outputCharacter, fusionPosition.toOffset());

        // 4. Update the player's progress
        ref
            .read(playerProgressProvider.notifier)
            .addNewCharacter(outputCharacter.id);
            
        FlameAudio.play('success.wav');

        // TODO: Add a success particle effect at fusionPosition
      }
    } else {
      // FUSION FAILED
      FlameAudio.play('fail.wav');
      
      // TODO: Add a "shake" or "bump" animation to the components to show a failed attempt
    }
  }
}