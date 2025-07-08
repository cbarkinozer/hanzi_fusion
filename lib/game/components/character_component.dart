// FILE: lib/game/components/character_component.dart

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/game/hanzi_fusion_game.dart';

class CharacterComponent extends PositionComponent
    with DragCallbacks, CollisionCallbacks, HasGameReference<HanziFusionGame> {
  final GameCharacter character;

  CharacterComponent({
    required this.character,
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(80),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
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
    // When the drag ends, ask the game to handle a potential fusion.
    game.handleFusion(this);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is CharacterComponent) {
      // When we collide, we tell the game who we are colliding with.
      game.latestCollisionTarget = other;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is CharacterComponent) {
      // When we stop colliding, we clear the target.
      game.latestCollisionTarget = null;
    }
  }
}