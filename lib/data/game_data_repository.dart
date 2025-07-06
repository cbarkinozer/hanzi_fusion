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
  late final Map<int, GameCharacter> characterMap;

  Future<void> loadData() async {
    // Load and parse characters
    final charactersJsonString = await rootBundle.loadString('assets/data/characters.json');
    final List<dynamic> charactersJson = json.decode(charactersJsonString);
    characters = charactersJson.map((json) => GameCharacter.fromJson(json)).toList();
    
    // Create a quick-lookup map for characters by ID
    characterMap = {for (var char in characters) char.id: char};

    // Load and parse recipes
    final recipesJsonString = await rootBundle.loadString('assets/data/recipes.json');
    final List<dynamic> recipesJson = json.decode(recipesJsonString);
    recipes = recipesJson.map((json) => Recipe.fromJson(json)).toList();
  }
}

// A Riverpod provider that creates and holds a single instance of our repository.
// The `keepAlive` flag ensures the data is loaded once and not disposed.
@Riverpod(keepAlive: true)
Future<GameDataRepository> gameDataRepository(Ref ref) async {
  final repository = GameDataRepository();
  await repository.loadData();
  return repository;
}