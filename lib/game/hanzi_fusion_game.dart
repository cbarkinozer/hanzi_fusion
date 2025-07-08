// lib/game/hanzi_fusion_game.dart

import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/game/components/character_component.dart';
import 'package:hanzi_fusion/game/effects/shake_effect.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';
import 'package:hanzi_fusion/providers/settings_provider.dart';

class HanziFusionGame extends FlameGame with HasCollisionDetection {
  final WidgetRef ref;
  HanziFusionGame({required this.ref});

  CharacterComponent? latestCollisionTarget;

  @override
  Color backgroundColor() => const Color(0xFF202020);

  @override
  Future<void> onLoad() async {
    debugMode = true;
    // Load all audio files
    await FlameAudio.audioCache.loadAll(['success.mp3', 'fail.mp3', 'click.mp3']);
  }

  void addCharacterFromDrop(GameCharacter character, Offset screenPosition) {
    final alreadyExists = world.children
        .whereType<CharacterComponent>()
        .any((component) => component.character.id == character.id);

    if (alreadyExists) {
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
      return;
    }

    final gameData = ref.read(gameDataRepositoryProvider).value;
    final sfxEnabled = ref.read(settingsProvider).value?.sfxEnabled ?? true;

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
        final fusionPosition = latestCollisionTarget!.position.clone();

        world.remove(droppedComponent);
        world.remove(latestCollisionTarget!);

        _spawnCharacter(outputCharacter, fusionPosition);
        _addSuccessParticles(fusionPosition); // Add particle effect

        ref
            .read(playerProgressProvider.notifier)
            .addNewDiscovery(outputCharacter.id, recipeKey);

        if (sfxEnabled) {
          FlameAudio.play('success.mp3', volume: 0.5);
        }
      }
    } else {
      // FUSION FAILED
      if (sfxEnabled) {
        FlameAudio.play('fail.mp3', volume: 0.5);
      }
      // Add shake effect to both components
      droppedComponent.add(shakeEffect());
      latestCollisionTarget?.add(shakeEffect());
    }

    latestCollisionTarget = null;
  }
  
  // Method to create a particle burst on successful fusion
  void _addSuccessParticles(Vector2 position) {
    final random = Random();
    world.add(
      ParticleSystemComponent(
        position: position,
        particle: Particle.generate(
          count: 25,
          lifespan: 1.0,
          generator: (i) => AcceleratedParticle(
            acceleration: Vector2(0, 250), // Gravity effect
            speed: Vector2(
              random.nextDouble() * 300 - 150, // Random horizontal velocity
              -random.nextDouble() * 400, // Initial upward velocity
            ),
            child: CircleParticle(
              radius: 2.5,
              paint: Paint()..color = Colors.amber.withAlpha(128),
            ),
          ),
        ),
      ),
    );
  }
}