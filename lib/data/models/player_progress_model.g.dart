// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerProgressData _$PlayerProgressDataFromJson(Map<String, dynamic> json) =>
    _PlayerProgressData(
      discoveredCharacterIds: (json['discoveredCharacterIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      discoveredRecipeKeys: (json['discoveredRecipeKeys'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
      uniqueFailedAttempts: (json['uniqueFailedAttempts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      hintsUsed: (json['hintsUsed'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PlayerProgressDataToJson(_PlayerProgressData instance) =>
    <String, dynamic>{
      'discoveredCharacterIds': instance.discoveredCharacterIds,
      'discoveredRecipeKeys': instance.discoveredRecipeKeys.toList(),
      'uniqueFailedAttempts': instance.uniqueFailedAttempts.toList(),
      'hintsUsed': instance.hintsUsed,
    };
