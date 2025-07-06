// FILE: lib/game/components/character_component.dart

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/game/hanzi_fusion_game.dart';

// Add the CollisionCallbacks mixin
class CharacterComponent extends PositionComponent
    with DragCallbacks, CollisionCallbacks, HasGameReference<HanziFusionGame> {
  final GameCharacter character;
  final VoidCallback? onComponentRemoved;
  
  // A flag to prevent multiple fusion checks for the same collision event.
  bool isBeingFused = false;

  CharacterComponent({
    required this.character,
    required Vector2 position,
    this.onComponentRemoved,
  }) : super(
          position: position,
          size: Vector2.all(80),
          anchor: Anchor.center,
        );

  @override
  void onRemove() {
    super.onRemove();
    onComponentRemoved?.call();
  }

  @override
  Future<void> onLoad() async {
    // Add a hitbox to this component.
    add(RectangleHitbox());

    add(
      RectangleComponent(
        size: size,
        paint: Paint()..color = const Color(0xFF404040),
        children: [
          TextComponent(
            text: character.char,
            textRenderer: TextPaint(
              style: const TextStyle(
                fontSize: 48,
                color: Colors.white,
              ),
            ),
            anchor: Anchor.center,
            position: size / 2,
          ),
        ],
      ),
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    // After dragging stops, reset the flag so it can fuse again.
    isBeingFused = false;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    
    if (isDragged) return; // Don't try to fuse while the user is actively dragging this component.

    if (other is CharacterComponent) {
      // To avoid both components trying to initiate a fusion, we ensure only one does.
      if (isBeingFused || other.isBeingFused) return;
      isBeingFused = true;
      other.isBeingFused = true;

      // Find the game instance and call the fusion-checking method
      game.checkForFusion(this, other);
    }
  }
}