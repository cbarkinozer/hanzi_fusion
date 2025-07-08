import 'package:flame/effects.dart';
import 'package:flame/components.dart';

// A shake effect using a sequence of small movements.
SequenceEffect shakeEffect() {
  const double shakeAmount = 4.0;
  const double shakeDuration = 0.08;
  return SequenceEffect(
    [
      MoveByEffect(Vector2(shakeAmount, 0), EffectController(duration: shakeDuration / 2, reverseDuration: shakeDuration / 2)),
      MoveByEffect(Vector2(-shakeAmount, 0), EffectController(duration: shakeDuration / 2, reverseDuration: shakeDuration / 2)),
      MoveByEffect(Vector2(0, shakeAmount), EffectController(duration: shakeDuration / 2, reverseDuration: shakeDuration / 2)),
      MoveByEffect(Vector2(0, -shakeAmount), EffectController(duration: shakeDuration / 2, reverseDuration: shakeDuration / 2)),
    ],
    infinite: false,
  );
}