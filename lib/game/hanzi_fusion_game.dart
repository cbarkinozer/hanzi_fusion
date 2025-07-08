// lib/game/hanzi_fusion_game.dart

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/game/components/character_component.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';

class HanziFusionGame extends FlameGame with HasCollisionDetection {
  final WidgetRef ref;
  HanziFusionGame({required this.ref});

  CharacterComponent? latestCollisionTarget;

  @override
  Color backgroundColor() => const Color(0xFF202020);

  @override
  Future<void> onLoad() async {
    debugMode = true;
    // Pre-load audio files for better performance
    await FlameAudio.audioCache.loadAll(['success.mp3', 'fail.mp3']);
  }

  void addCharacterFromDrop(GameCharacter character, Offset screenPosition) {
    final alreadyExists = world.children
        .whereType<CharacterComponent>()
        .any((component) => component.character.id == character.id);

    if (alreadyExists) {
      // Character already on screen!
      return;
    }
    
    final worldPosition =
        camera.globalToLocal(Vector2(screenPosition.dx, screenPosition.dy));
    _spawnCharacter(character, worldPosition);
  }

  void _spawnCharacter(GameCharacter character, Vector2 position) {
    final component = CharacterComponent(
      character: character,
      position: position,
    );
    world.add(component);
  }

  void handleFusion(CharacterComponent droppedComponent) {
    if (latestCollisionTarget == null) {
      return; // Not dropped on anything
    }

    final gameData = ref.read(gameDataRepositoryProvider).value;
    if (gameData == null) return;

    final sortedIds = [
      droppedComponent.character.id,
      latestCollisionTarget!.character.id
    ]..sort();

    final recipeKey = "${sortedIds[0]}-${sortedIds[1]}";
    final recipe = gameData.recipeMapByKey[recipeKey];

    if (recipe != null) {
      // FUSION SUCCESS!
      final outputCharacter = gameData.characterMapById[recipe.outputId];
      if (outputCharacter != null) {
        final fusionPosition = latestCollisionTarget!.position;

        world.remove(droppedComponent);
        world.remove(latestCollisionTarget!);

        _spawnCharacter(outputCharacter, fusionPosition);

        // Call the updated provider method with both the new character and the recipe key
        ref
            .read(playerProgressProvider.notifier)
            .addNewDiscovery(outputCharacter.id, recipeKey);

        FlameAudio.play('success.mp3', volume: 0.5);
      }
    } else {
      // FUSION FAILED
      FlameAudio.play('fail.mp3', volume: 0.5);
    }

    latestCollisionTarget = null;
  }
}