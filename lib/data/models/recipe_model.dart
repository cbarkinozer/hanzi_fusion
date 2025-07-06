import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class Recipe {
  @JsonKey(name: 'input_ids')
  final List<int> inputIds;
  @JsonKey(name: 'output_id')
  final int outputId;

  Recipe({
    required this.inputIds,
    required this.outputId,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}