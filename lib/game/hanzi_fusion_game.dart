import 'package:flame/game.dart';
import 'package:flutter/material.dart';

// This is the main canvas for our game where fusions will happen.
// For now, it's just a dark background.
class HanziFusionGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF202020);
}