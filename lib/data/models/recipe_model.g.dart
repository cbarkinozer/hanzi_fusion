// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawRecipe _$RawRecipeFromJson(Map<String, dynamic> json) => RawRecipe(
  inputs: (json['inputs'] as List<dynamic>).map((e) => e as String).toList(),
  output: json['output'] as String,
);

Map<String, dynamic> _$RawRecipeToJson(RawRecipe instance) => <String, dynamic>{
  'inputs': instance.inputs,
  'output': instance.output,
};

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
  inputIds: (json['input_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  outputId: (json['output_id'] as num).toInt(),
);

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
  'input_ids': instance.inputIds,
  'output_id': instance.outputId,
};
