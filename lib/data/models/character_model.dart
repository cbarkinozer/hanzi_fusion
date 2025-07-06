import 'package:json_annotation/json_annotation.dart';

part 'character_model.g.dart';

@JsonSerializable()
class GameCharacter {
  final int id;
  final String char;
  final String pinyin;
  final String meaning;
  // This field is in the README example but not your JSON, we'll make it optional.
  @JsonKey(name: 'is_base_element', defaultValue: false)
  final bool isBaseElement;

  GameCharacter({
    required this.id,
    required this.char,
    required this.pinyin,
    required this.meaning,
    required this.isBaseElement,
  });

  factory GameCharacter.fromJson(Map<String, dynamic> json) =>
      _$GameCharacterFromJson(json);

  Map<String, dynamic> toJson() => _$GameCharacterToJson(this);
}