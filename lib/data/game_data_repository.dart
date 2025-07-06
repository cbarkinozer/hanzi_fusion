// FILE: lib/data/game_data_repository.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/models/character_model.dart';
import 'package:hanzi_fusion/data/models/recipe_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_data_repository.g.dart';

class GameDataRepository {
  late final List<GameCharacter> characters;
  late final List<Recipe> recipes;
  late final Map<int, GameCharacter> characterMapById;
  late final Map<String, GameCharacter> characterMapByChar;

  Future<void> loadData() async {
    // 1. Load and parse characters FIRST. This is now mandatory.
    final charactersJsonString = await rootBundle.loadString('assets/data/characters.json');
    final List<dynamic> charactersJson = json.decode(charactersJsonString);
    characters = charactersJson.map((json) => GameCharacter.fromJson(json)).toList();
    
    // 2. Create quick-lookup maps for characters.
    characterMapById = {for (var char in characters) char.id: char};
    characterMapByChar = {for (var char in characters) char.char: char};

    // 3. Load the new, human-readable recipes.
    final rawRecipesJsonString = await rootBundle.loadString('assets/data/recipes.json');
    final List<dynamic> rawRecipesJson = json.decode(rawRecipesJsonString);
    final rawRecipes = rawRecipesJson.map((json) => RawRecipe.fromJson(json)).toList();

    // 4. Convert the "RawRecipes" (using strings) into "Recipes" (using IDs).
    recipes = [];
    for (var rawRecipe in rawRecipes) {
      // Find the character objects for the inputs and output
      final input1 = characterMapByChar[rawRecipe.inputs[0]];
      final input2 = characterMapByChar[rawRecipe.inputs[1]];
      final output = characterMapByChar[rawRecipe.output];

      // If all characters are found in our data, create the ID-based recipe
      if (input1 != null && input2 != null && output != null) {
        recipes.add(Recipe(
          inputIds: [input1.id, input2.id],
          outputId: output.id,
        ));
      } else {
        // This is a helpful warning during development!
        print('Warning: Could not find characters for recipe: ${rawRecipe.inputs} -> ${rawRecipe.output}');
      }
    }
  }
}

@Riverpod(keepAlive: true)
Future<GameDataRepository> gameDataRepository(Ref ref) async {
  final repository = GameDataRepository();
  await repository.loadData();
  return repository;
}