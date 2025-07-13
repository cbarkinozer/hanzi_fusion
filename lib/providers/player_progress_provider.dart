// lib/providers/player_progress_provider.dart
import 'dart:convert';
import 'dart:math';

import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/data/models/player_progress_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'player_progress_provider.g.dart';

/// A provider that calculates the number of hints the player has available.
@riverpod
int availableHints(AvailableHintsRef ref) {
  final progress = ref.watch(playerProgressProvider).valueOrNull;
  if (progress == null) return 0;

  // A hint is earned for every 10 unique failed attempts.
  const hintThreshold = 10;

  final hintsEarned = progress.uniqueFailedAttempts.length ~/ hintThreshold;
  final hintsUsed = progress.hintsUsed;

  // Return the number of earned hints that haven't been used yet.
  return max(0, hintsEarned - hintsUsed);
}

@riverpod
class PlayerProgress extends _$PlayerProgress {
  late SharedPreferences _prefs;
  static const _progressKey = 'playerProgressData';

  // The initial characters
  final _initialCharacterIds = [4149, 4143, 131];

  @override
  Future<PlayerProgressData> build() async {
    ref.keepAlive(); 
    _prefs = await SharedPreferences.getInstance();
    final savedJsonString = _prefs.getString(_progressKey);

    if (savedJsonString == null) {
      return PlayerProgressData(
        discoveredCharacterIds: _initialCharacterIds,
        discoveredRecipeKeys: {},
        uniqueFailedAttempts: {},
        hintsUsed: 0,
      );
    }
    
    return PlayerProgressData.fromJson(json.decode(savedJsonString));
  }

  Future<void> addNewDiscovery(int newCharId, String recipeKey) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    
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

  Future<void> addFailedAttempt(String failedKey) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final newState = currentState.copyWith(
      uniqueFailedAttempts: {...currentState.uniqueFailedAttempts, failedKey},
    );

    state = AsyncData(newState);
    await _prefs.setString(_progressKey, json.encode(newState.toJson()));
  }

  /// Finds a helpful hint, adds the missing character to the inventory,
  /// and returns the revealed character.
  Future<GameCharacter?> useHint() async {
    // Double-check eligibility before using a hint.
    if (ref.read(availableHintsProvider) <= 0) return null;

    final gameData = await ref.read(gameDataRepositoryProvider.future);
    final progress = state.valueOrNull;
    if (progress == null) return null;

    final inventoryIds = progress.discoveredCharacterIds.toSet();
    
    // Find recipes where the player has exactly one of the two inputs, but not the output.
    // This provides the most "unlocking" potential.
    final potentialHintRecipes = gameData.recipes.where((recipe) {
      final hasInput1 = inventoryIds.contains(recipe.inputIds[0]);
      final hasInput2 = inventoryIds.contains(recipe.inputIds[1]);
      final hasOutput = inventoryIds.contains(recipe.outputId);
      // The player has one input, but not the other, and not the result.
      return (hasInput1 ^ hasInput2) && !hasOutput;
    }).toList();


    if (potentialHintRecipes.isEmpty) {
      return null; // No suitable hint found
    }

    // Pick a random recipe from the suitable ones.
    final hintRecipe = potentialHintRecipes[Random().nextInt(potentialHintRecipes.length)];
    
    // Find out which character is the missing one.
    final missingId = inventoryIds.contains(hintRecipe.inputIds[0]) 
        ? hintRecipe.inputIds[1] 
        : hintRecipe.inputIds[0];
        
    final revealedCharacter = gameData.characterMapById[missingId];
    if (revealedCharacter == null) return null;

    // Update the player's progress
    final newState = progress.copyWith(
      discoveredCharacterIds: [...progress.discoveredCharacterIds, missingId],
      hintsUsed: progress.hintsUsed + 1,
    );
    state = AsyncData(newState);
    await _prefs.setString(_progressKey, json.encode(newState.toJson()));

    return revealedCharacter;
  }

  Future<void> resetProgress() async {
    final initialState = PlayerProgressData(
      discoveredCharacterIds: _initialCharacterIds,
      discoveredRecipeKeys: {},
      uniqueFailedAttempts: {},
      hintsUsed: 0,
    );
    state = AsyncData(initialState);
    await _prefs.remove(_progressKey);
  }
}