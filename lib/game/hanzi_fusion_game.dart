// FILE: lib/game/hanzi_fusion_game.dart

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/game/components/character_component.dart';

// The mixins are now correct because the class is used properly.
class HanziFusionGame extends FlameGame with HasCollisionDetection {
  
  // No constructor or ref needed. It's self-contained.

  @override
  Color backgroundColor() => const Color(0xFF202020);

  @override
  Future<void> onLoad() async {
    // Debug mode is great for seeing hitboxes.
    debugMode = true;
  }

  // This is a public method for the UI to call.
  // It takes a screen position (Offset) and handles the conversion.
  void addCharacterFromDrop(GameCharacter character, Offset screenPosition) {
    // Convert the screen tap position to the game's world position
    final worldPosition = camera.globalToLocal(
      Vector2(screenPosition.dx, screenPosition.dy),
    );
    
    // Create and add the component to the game world
    final component = CharacterComponent(
      character: character,
      position: worldPosition,
    );
    world.add(component);
  }
}