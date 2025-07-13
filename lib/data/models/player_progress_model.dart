// lib/data/models/player_progress_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_progress_model.freezed.dart';
part 'player_progress_model.g.dart';

@freezed
abstract class PlayerProgressData with _$PlayerProgressData {
  const factory PlayerProgressData({
    required List<int> discoveredCharacterIds,
    required Set<String> discoveredRecipeKeys,
    @Default({}) Set<String> uniqueFailedAttempts,
    @Default(0) int hintsUsed,
  }) = _PlayerProgressData;

  factory PlayerProgressData.fromJson(Map<String, dynamic> json) =>
      _$PlayerProgressDataFromJson(json);
}