// FILE: lib/data/models/recipe_model.dart

import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

/// A temporary class used only for parsing the human-readable recipe JSON.
/// This will be converted into the ID-based `Recipe` class for game use.
@JsonSerializable()
class RawRecipe {
  final List<String> inputs;
  final String output;

  RawRecipe({required this.inputs, required this.output});

  factory RawRecipe.fromJson(Map<String, dynamic> json) =>
      _$RawRecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RawRecipeToJson(this);
}


/// The final, processed Recipe class that the game engine uses.
/// It uses integer IDs for fast lookups.
@JsonSerializable()
class Recipe {
  @JsonKey(name: 'input_ids')
  final List<int> inputIds;
  @JsonKey(name: 'output_id')
  final int outputId;

  Recipe({
    required this.inputIds,
    required this.outputId,
  }) {
    // Ensure inputs are always sorted for consistent lookups
    inputIds.sort();
  }

  // The fromJson and toJson for this class are no longer used to read the file,
  // but they are kept for potential future use (e.g., saving data).
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}