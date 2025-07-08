// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_fusion/providers/level_provider.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';

part 'theme_provider.g.dart';

@riverpod
Color appThemeColor(Ref ref) {
  final levels = ref.watch(levelsProvider);
  final progress = ref.watch(playerProgressProvider).value;

  if (levels.isEmpty || progress == null) {
    return const Color(0xFF2A9D8F); 
  }

  int highestLevel = 0;
  for (final level in levels) {
    if (level.characterIds.any((id) => progress.discoveredCharacterIds.contains(id))) {
      if (level.level > highestLevel) {
        highestLevel = level.level;
      }
    }
  }

  final currentLevel = levels.firstWhere(
    (l) => l.level == highestLevel,
    orElse: () => levels.first,
  );

  return currentLevel.themeColor;
}