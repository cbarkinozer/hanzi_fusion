// lib/data/models/level_model.dart
import 'package:flutter/material.dart';

class Level {
  final int level;
  final String name;
  final List<int> characterIds;
  final Color themeColor;

  Level({
    required this.level,
    required this.name,
    required this.characterIds,
    required this.themeColor,
  });
}