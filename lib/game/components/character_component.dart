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

    // UPDATED: Replaced the basic RectangleComponent with a custom one
    // that includes rounded corners and a shadow.
    add(_CharacterTile(size: size));
    add(
      HanziTextComponent(character.char)
        ..position = size / 2, // set the position to the middle of the box
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

/// A custom component to render the character tile with a shadow
/// and rounded corners for a more polished look.
class _CharacterTile extends PositionComponent {
  // CORRECTED: Use the super-initializer to pass the size to the PositionComponent,
  // which correctly handles the 'size' parameter.
  _CharacterTile({required super.size});

  // Define the paint for the tile's background.
  final Paint _backgroundPaint = Paint()..color = const Color(0xFF404040);
  
  // These will be initialized in onLoad when the size is guaranteed to be set.
  late final RRect _rrect;
  late final Path _path;

  @override
  Future<void> onLoad() async {
    // Initialize the shapes based on the component's size.
    _rrect = RRect.fromRectAndRadius(
      size.toRect(), // The `size` property is inherited from PositionComponent.
      const Radius.circular(12.0),
    );
    _path = Path()..addRRect(_rrect);
  }

  @override
  void render(Canvas canvas) {
    // A check to ensure the component is loaded before trying to render.
    if (!isLoaded) return;
    
    // 1. Draw a soft shadow beneath the tile.
    canvas.drawShadow(_path, Colors.black.withAlpha(200), 4.0, true);
    
    // 2. Draw the rounded rectangle tile on top of the shadow.
    canvas.drawRRect(_rrect, _backgroundPaint);
  }
}