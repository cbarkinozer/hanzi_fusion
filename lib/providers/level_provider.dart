// lib/providers/level_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/data/models/level_model.dart';
import 'package:hanzi_fusion/data/hsk_data.dart';

part 'level_provider.g.dart';

@riverpod
List<Level> levels(Ref ref) {
  final gameData = ref.watch(gameDataRepositoryProvider).value;
  if (gameData == null) return [];

  final allCharIds = gameData.characterMapById.keys.toSet();

  List<Level> generateLevels() {
    return [
      Level(
        level: 0,
        name: 'HSK 0 - Primitives',
        characterIds: hsk0Ids.where((id) => allCharIds.contains(id)).toList()..sort(),
      ),
      Level(
        level: 1,
        name: 'HSK 1',
        characterIds: allCharIds.where((id) => id >= 1 && id <= 150).toList()..sort(),
      ),
      Level(
        level: 2,
        name: 'HSK 2',
        characterIds: allCharIds.where((id) => id >= 151 && id <= 300).toList()..sort(),
      ),
      Level(
        level: 3,
        name: 'HSK 3',
        characterIds: allCharIds.where((id) => id >= 301 && id <= 600).toList()..sort(),
      ),
      Level(
        level: 4,
        name: 'HSK 4',
        characterIds: allCharIds.where((id) => id >= 601 && id <= 1200).toList()..sort(),
      ),
      Level(
        level: 5,
        name: 'HSK 5',
        characterIds: allCharIds.where((id) => id >= 1201 && id <= 2500).toList()..sort(),
      ),
      Level(
        level: 6,
        name: 'HSK 6',
        characterIds: allCharIds.where((id) => id >= 2501 && id <= 5000).toList()..sort(),
      ),
    ];
  }

  return generateLevels();
}