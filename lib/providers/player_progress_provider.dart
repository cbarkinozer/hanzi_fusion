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

  // A sensible set of starting primitive characters.
  final _initialCharacterIds = {131, 94, 442, 85, 5206, 99, 784, 87, 137};

  @override
  Future<PlayerProgressData> build() async {
    // Keep the provider alive across screen changes.
    ref.keepAlive(); 
    _prefs = await SharedPreferences.getInstance();

    final savedJsonString = _prefs.getString(_progressKey);

    if (savedJsonString == null) {
      // If no saved data, start with the initial set.
      return PlayerProgressData(
        discoveredCharacterIds: _initialCharacterIds,
        discoveredRecipeKeys: {},
      );
    }

    // Otherwise, load the saved data.
    return PlayerProgressData.fromJson(json.decode(savedJsonString));
  }

  Future<void> addNewDiscovery(int newCharId, String recipeKey) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    
    // Create the new state with added discoveries.
    final newState = currentState.copyWith(
      discoveredCharacterIds: {...currentState.discoveredCharacterIds, newCharId},
      discoveredRecipeKeys: {...currentState.discoveredRecipeKeys, recipeKey}
    );

    // Update the state to notify listeners.
    state = AsyncData(newState);

    // Persist the new state to local storage.
    await _prefs.setString(_progressKey, json.encode(newState.toJson()));
  }

  Future<void> resetProgress() async {
    final initialState = PlayerProgressData(
      discoveredCharacterIds: _initialCharacterIds,
      discoveredRecipeKeys: {},
    );
    // Update state to initial data
    state = AsyncData(initialState);
    // Clear from storage
    await _prefs.remove(_progressKey);
  }
}