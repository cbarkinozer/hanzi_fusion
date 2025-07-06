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

  // A list to keep track of components colliding with the one being dragged
  CharacterComponent? latestCollisionTarget;

  @override
  Color backgroundColor() => const Color(0xFF202020);

  @override
  Future<void> onLoad() async {
    debugMode = true;
    // TODO: Pre-load your audio files
    // await FlameAudio.audioCache.loadAll(['success.wav', 'fail.wav', 'pop.wav']);
  }

  /// This is a public method for the UI to call.
  /// It takes a screen position (Offset) and handles the conversion.
  void addCharacterFromDrop(GameCharacter character, Offset screenPosition) {
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
    _spawnCharacter(character, worldPosition);
  }

  /// Private method to spawn a character at a specific world position.
  void _spawnCharacter(GameCharacter character, Vector2 position) {
    final component = CharacterComponent(
      character: character,
      position: position,
    );
    world.add(component);
  }

  /// Handles the fusion logic when a drag gesture ends.
  void handleFusion(CharacterComponent droppedComponent) {
    if (latestCollisionTarget == null) {
      // TODO: Add a "shake" or "bump" animation for a failed drop.
      return; // Not dropped on anything
    }

    final gameData = ref.read(gameDataRepositoryProvider).value;
    if (gameData == null) return;

    final inputIds = [
      droppedComponent.character.id,
      latestCollisionTarget!.character.id
    ]..sort();

    final recipe = gameData.recipes.cast<Recipe?>().firstWhere(
          (r) =>
              r != null &&
              r.inputIds.length == 2 &&
              r.inputIds[0] == inputIds[0] &&
              r.inputIds[1] == inputIds[1],
          orElse: () => null,
        );

    if (recipe != null) {
      // FUSION SUCCESS!
      final outputCharacter = gameData.characterMapById[recipe.outputId];
      if (outputCharacter != null) {
        final fusionPosition = latestCollisionTarget!.position;

        world.remove(droppedComponent);
        world.remove(latestCollisionTarget!);

        _spawnCharacter(outputCharacter, fusionPosition);

        ref
            .read(playerProgressProvider.notifier)
            .addNewCharacter(outputCharacter.id);

        // TODO: Play a success sound effect
        FlameAudio.play('success.wav');
        // TODO: Add a success particle effect at fusionPosition
      }
    } else {
      // FUSION FAILED
      // TODO: Play a failure sound effect
      FlameAudio.play('fail.wav');
      // TODO: Add a "shake" or "bump" animation to the components
    }

    // Reset collision target
    latestCollisionTarget = null;
  }
}