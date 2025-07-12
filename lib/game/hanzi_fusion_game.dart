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
import 'package:hanzi_fusion/data/models/discovery_model.dart';
import 'package:hanzi_fusion/game/components/character_component.dart';
import 'package:hanzi_fusion/game/effects/shake_effect.dart';
import 'package:hanzi_fusion/providers/game_event_provider.dart';
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
    await FlameAudio.audioCache.loadAll(['success.mp3', 'fail.mp3', 'click.mp3', 'drop.mp3']);
  }

  void addCharacterFromDrop(GameCharacter character, Offset screenPosition) {
    final sfxEnabled = ref.read(settingsProvider).value?.sfxEnabled ?? true;
    final worldPosition = camera.globalToLocal(Vector2(screenPosition.dx, screenPosition.dy));
    final componentsUnderDrop = componentsAtPoint(worldPosition);
    final target = componentsUnderDrop.whereType<CharacterComponent>().firstOrNull;
    
    if (target != null) {
      // If dropped on a character try to merge
      final dummyComponent = CharacterComponent(character: character, position: worldPosition);
      handleFusion(dummyComponent, directTarget: target);
    } else {
      // If dropped on an empty place just add the character
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

  void handleFusion(CharacterComponent droppedComponent, {CharacterComponent? directTarget}) {
    final fusionTarget = directTarget ?? latestCollisionTarget;

    if (fusionTarget == null) return;

    final gameData = ref.read(gameDataRepositoryProvider).value;
    final sfxEnabled = ref.read(settingsProvider).value?.sfxEnabled ?? true;
    if (gameData == null) return;

    final sortedIds = [droppedComponent.character.id, fusionTarget.character.id]..sort();
    final recipeKey = "${sortedIds[0]}-${sortedIds[1]}";
    final recipe = gameData.recipeMapByKey[recipeKey];

    if (recipe != null) { // BİRLEŞME BAŞARILI
      final outputCharacter = gameData.characterMapById[recipe.outputId];
      if (outputCharacter != null) {
        // Yeni karakter, birleşmenin olduğu yerde (hedefin konumunda) oluşur.
        final newCharPosition = fusionTarget.position.clone();

        world.remove(droppedComponent);
        world.remove(fusionTarget);

        _spawnCharacter(outputCharacter, newCharPosition);
        _addSuccessParticles(newCharPosition);

        ref.read(playerProgressProvider.notifier).addNewDiscovery(outputCharacter.id, recipeKey);
        
        // Trigger the discovery animation
        ref.read(newDiscoveryProvider.notifier).state = Discovery(
            input1: gameData.characterMapById[sortedIds[0]]!,
            input2: gameData.characterMapById[sortedIds[1]]!,
            output: outputCharacter,
        );
        
        if (sfxEnabled) FlameAudio.play('success.mp3', volume: 0.5);
      }
    } else { // BİRLEŞME BAŞARISIZ
      if (sfxEnabled) FlameAudio.play('fail.mp3', volume: 0.5);
      droppedComponent.add(shakeEffect());
      fusionTarget.add(shakeEffect());
    }

    latestCollisionTarget = null;
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
            speed: Vector2(random.nextDouble() * 300 - 150, -random.nextDouble() * 400),
            child: CircleParticle(radius: 2.5, paint: Paint()..color = Colors.amber.withAlpha(230)),
          ),
        ),
      ),
    );
  }
}