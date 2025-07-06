// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameCharacter _$GameCharacterFromJson(Map<String, dynamic> json) =>
    GameCharacter(
      id: (json['id'] as num).toInt(),
      char: json['char'] as String,
      pinyin: json['pinyin'] as String,
      meaning: json['meaning'] as String,
      isBaseElement: json['is_base_element'] as bool? ?? false,
    );

Map<String, dynamic> _$GameCharacterToJson(GameCharacter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'char': instance.char,
      'pinyin': instance.pinyin,
      'meaning': instance.meaning,
      'is_base_element': instance.isBaseElement,
    };
