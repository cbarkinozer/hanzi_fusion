// lib/data/models/level_model.dart
class Level {
  final int level;
  final String name;
  final List<int> characterIds;

  Level({
    required this.level,
    required this.name,
    required this.characterIds,
  });
}