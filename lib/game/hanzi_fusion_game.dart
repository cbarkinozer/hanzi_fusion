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
  
  late Vector2 _nextSpawnPosition;
  late final Vector2 _initialSpawnPosition;
  final double _spawnPadding = 10.0;

  @override
  Color backgroundColor() => const Color(0xFF202020);

  @override
  Future<void> onLoad() async {
    debugMode = true;
    await FlameAudio.audioCache.loadAll(['success.mp3', 'fail.mp3', 'click.mp3', 'drop.mp3']);
    
    final spawnX = size.x * 0.85;
    final spawnY = size.y * 0.15;
    _initialSpawnPosition = Vector2(spawnX, spawnY);
    _nextSpawnPosition = _initialSpawnPosition.clone();
  }

  void addCharacterFromDrop(GameCharacter character, Offset screenPosition) {
    final sfxEnabled = ref.read(settingsProvider).value?.sfxEnabled ?? true;
    
    // --- FIX IS HERE ---
    // Correctly convert Offset to Vector2
    final worldPosition = camera.globalToLocal(Vector2(screenPosition.dx, screenPosition.dy));
    // --- END OF FIX ---

    // Check if dropping onto an existing character for instant fusion
    final componentsUnderDrop = componentsAtPoint(worldPosition);
    final target = componentsUnderDrop.whereType<CharacterComponent>().firstOrNull;
    
    if (target != null) {
      // INSTANT FUSION ATTEMPT
      final dummyComponent = CharacterComponent(character: character, position: worldPosition);
      handleFusion(dummyComponent, isInstantFusion: true, instantTarget: target);
    } else {
      // Regular drop onto the board
      if (sfxEnabled) {
        FlameAudio.play('drop.mp3', volume: 0.6);
      }
      _spawnCharacter(character, worldPosition);
    }
  }

  void _spawnCharacter(GameCharacter character, Vector2 position) {
    final component = CharacterComponent(
      character: character,
      position: position,
    );
    world.add(component);
  }

  void handleFusion(CharacterComponent droppedComponent, {bool isInstantFusion = false, CharacterComponent? instantTarget}) {
    final target = isInstantFusion ? instantTarget : latestCollisionTarget;

    if (target == null) {
      return;
    }

    final gameData = ref.read(gameDataRepositoryProvider).value;
    final sfxEnabled = ref.read(settingsProvider).value?.sfxEnabled ?? true;

    if (gameData == null) return;

    final sortedIds = [
      droppedComponent.character.id,
      target.character.id
    ]..sort();

    final recipeKey = "${sortedIds[0]}-${sortedIds[1]}";
    final recipe = gameData.recipeMapByKey[recipeKey];

    if (recipe != null) {
      // FUSION SUCCESS!
      final outputCharacter = gameData.characterMapById[recipe.outputId];
      if (outputCharacter != null) {
        final particlePosition = target.position.clone();
        final newCharPosition = _getAndIncrementSpawnPosition();

        if (!isInstantFusion) {
          world.remove(droppedComponent);
        }
        world.remove(target);

        _spawnCharacter(outputCharacter, newCharPosition);
        _addSuccessParticles(particlePosition);

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
      
      if (!isInstantFusion) {
        droppedComponent.add(shakeEffect());
      }
      target.add(shakeEffect());
    }

    if (!isInstantFusion) {
      latestCollisionTarget = null;
    }
  }
  
  Vector2 _getAndIncrementSpawnPosition() {
    final positionToReturn = _nextSpawnPosition.clone();
    
    _nextSpawnPosition.y += 80 + _spawnPadding;

    if (_nextSpawnPosition.y > size.y * 0.9) {
      _nextSpawnPosition = _initialSpawnPosition.clone();
    }
    
    return positionToReturn;
  }
  
  void _addSuccessParticles(Vector2 position) {
    final random = Random();
    world.add(
      ParticleSystemComponent(
        position: position,
        particle: Particle.generate(
          count: 25,
          lifespan: 1.0,
          generator: (i) => AcceleratedParticle(
            acceleration: Vector2(0, 250),
            speed: Vector2(
              random.nextDouble() * 300 - 150,
              -random.nextDouble() * 400,
            ),
            child: CircleParticle(
              radius: 2.5,
              paint: Paint()..color = Colors.amber.withAlpha(230),
            ),
          ),
        ),
      ),
    );
  }
}