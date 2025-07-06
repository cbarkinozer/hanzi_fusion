// FILE: lib/game/components/character_component.dart

import 'package:flame/collisions.dart'; // Import this
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';

// Add the CollisionCallbacks mixin
class CharacterComponent extends PositionComponent
    with DragCallbacks, CollisionCallbacks {
  final GameCharacter character;
  final VoidCallback? onComponentRemoved;

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
}