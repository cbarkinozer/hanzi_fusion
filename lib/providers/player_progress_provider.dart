import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'player_progress_provider.g.dart';

@riverpod
class PlayerProgress extends _$PlayerProgress {
  late SharedPreferences _prefs;

  // Define the starting character IDs.
  // Let's start with person (10), wood (123), and water (194).
  final _initialCharacterIds = [10, 123, 194];

  @override
  Future<Set<int>> build() async {
    _prefs = await SharedPreferences.getInstance();
    final discoveredIds = _prefs.getStringList('discoveredCharacterIds');

    if (discoveredIds == null) {
      // If no saved data, start with the initial set.
      return _initialCharacterIds.toSet();
    }

    // Otherwise, load the saved data.
    return discoveredIds.map(int.parse).toSet();
  }

  Future<void> addNewCharacter(int newId) async {
    // Get the current state
    final currentState = state.valueOrNull ?? <int>{};
    
    // Add the new ID
    final newState = {...currentState, newId};

    // Update the state to notify listeners
    state = AsyncData(newState);

    // Persist the new state to local storage
    await _prefs.setStringList(
      'discoveredCharacterIds',
      newState.map((id) => id.toString()).toList(),
    );
  }

  Future<void> resetProgress() async {
    // Update state to initial characters
    state = AsyncData(_initialCharacterIds.toSet());
    // Clear from storage
    await _prefs.remove('discoveredCharacterIds');
  }
}