// lib/providers/player_progress_provider.dart
import 'dart:convert';

import 'package:hanzi_fusion/data/models/player_progress_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'player_progress_provider.g.dart';

@riverpod
class PlayerProgress extends _$PlayerProgress {
  late SharedPreferences _prefs;
  static const _progressKey = 'playerProgressData';

  // The initial characters
  final _initialCharacterIds = [131, 94, 442, 85, 5206, 99, 784, 87, 137];

  @override
  Future<PlayerProgressData> build() async {
    ref.keepAlive(); 
    _prefs = await SharedPreferences.getInstance();
    final savedJsonString = _prefs.getString(_progressKey);

    if (savedJsonString == null) {
      return PlayerProgressData(
        discoveredCharacterIds: _initialCharacterIds,
        discoveredRecipeKeys: {},
      );
    }
    
    return PlayerProgressData.fromJson(json.decode(savedJsonString));
  }

  Future<void> addNewDiscovery(int newCharId, String recipeKey) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    
    // Check if the new character is already in the list
    final currentIds = List<int>.from(currentState.discoveredCharacterIds);
    if (!currentIds.contains(newCharId)) {
      currentIds.add(newCharId);
    }
    
    final newState = currentState.copyWith(
      discoveredCharacterIds: currentIds,
      discoveredRecipeKeys: {...currentState.discoveredRecipeKeys, recipeKey}
    );

    state = AsyncData(newState);
    await _prefs.setString(_progressKey, json.encode(newState.toJson()));
  }

  Future<void> resetProgress() async {
    final initialState = PlayerProgressData(
      discoveredCharacterIds: _initialCharacterIds,
      discoveredRecipeKeys: {},
    );
    state = AsyncData(initialState);
    await _prefs.remove(_progressKey);
  }
}