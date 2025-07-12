// lib/data/models/discovery_model.dart
import 'package:hanzi_fusion/data/models/character_model.dart';

class Discovery {
  final GameCharacter input1;
  final GameCharacter input2;
  final GameCharacter output;

  Discovery({
    required this.input1,
    required this.input2,
    required this.output,
  });
}