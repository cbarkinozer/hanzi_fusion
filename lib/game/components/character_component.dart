// FILE: lib/game/components/character_component.dart

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/game/components/hanzi_text_component.dart';
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
          HanziTextComponent(character.char)
            ..position = size / 2, // set the position to the middle of the box
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
    game.handleFusion(this);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is CharacterComponent) {
      game.latestCollisionTarget = other;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    game.latestCollisionTarget = null;
  }
}