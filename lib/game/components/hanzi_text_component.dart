// lib/game/components/hanzi_text_component.dart

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

// This component's only job is to draw text with the correct font at the right time.
class HanziTextComponent extends TextComponent {
  HanziTextComponent(String text)
      : super(
          text: text,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    // This method runs when the component is ready.
    // Setting the text style here ensures the font has loaded.
    textRenderer = TextPaint(
      style: const TextStyle(
        fontFamily: 'NotoSansSC', // The font family from pubspec.yaml
        fontSize: 48,
        color: Color(0xFFFFFFFF),
      ),
    );
    
    // We access the underlying painter to measure the text.
    size = (textRenderer as TextPaint).getLineMetrics(text).size;
    
    return super.onLoad();
  }
}