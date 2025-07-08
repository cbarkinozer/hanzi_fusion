// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerProgressDataImpl _$$PlayerProgressDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerProgressDataImpl(
      discoveredCharacterIds: (json['discoveredCharacterIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toSet(),
      discoveredRecipeKeys: (json['discoveredRecipeKeys'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$$PlayerProgressDataImplToJson(
        _$PlayerProgressDataImpl instance) =>
    <String, dynamic>{
      'discoveredCharacterIds': instance.discoveredCharacterIds.toList(),
      'discoveredRecipeKeys': instance.discoveredRecipeKeys.toList(),
    };
