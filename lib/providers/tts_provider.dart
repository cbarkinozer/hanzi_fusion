// lib/providers/tts_provider.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  Completer? _completer; // To wait for speech to complete

  TtsService() {
    _initTts();
  }

  Future<void> _initTts() async {
    // This handler is called when speech is complete
    _flutterTts.setCompletionHandler(() {
      _completer?.complete();
      _completer = null;
    });

    // Handle errors as well, so the app doesn't hang
    _flutterTts.setErrorHandler((msg) {
      if (kDebugMode) {
        print("TTS Error: $msg");
      }
      _completer?.completeError(msg);
      _completer = null;
    });

    // Set a proper Chinese voice or language
    await _setChineseVoice();

    await _flutterTts.setSpeechRate(0.5);   // Normal speech rate
    await _flutterTts.setPitch(1.0);        // Normal pitch
  }

  Future<void> _setChineseVoice() async {
    // For web, setting the language is more reliable.
    // For mobile, we can find and set a specific, high-quality voice.
    if (kIsWeb) {
      if (kDebugMode) {
        print("TTS Info: Running on Web. Attempting to set language to zh-CN.");
        print("TTS WARNING: Pronunciation quality depends on the browser's Web Speech API capabilities.");
      }
      await _flutterTts.setLanguage("zh-CN");
      return;
    }

    // On mobile, find a native voice for the best quality.
    try {
      List<dynamic> voices = await _flutterTts.getVoices;
      Map<String, String>? selectedVoice;

      for (var v in voices.cast<Map<String, String>>()) {
        final locale = v['locale'] ?? '';
        if (locale == 'zh-CN') {
          selectedVoice = v;
          break; // Found the best match
        }
        if (locale.startsWith('zh-')) {
          selectedVoice ??= v; // Found a fallback, keep looking for zh-CN
        }
      }

      if (selectedVoice != null) {
        await _flutterTts.setVoice(selectedVoice);
        if (kDebugMode) {
          print("TTS SUCCESS: Found and set native mobile voice: ${selectedVoice['name']}");
        }
      } else {
        if (kDebugMode) {
          print("TTS WARNING: No native Chinese voice found on mobile. Please install a Chinese voice pack in your device's settings.");
        }
        await _flutterTts.setLanguage("zh-CN");
      }
    } catch (e) {
      if (kDebugMode) {
        print("TTS ERROR: Could not get or set voices on mobile. $e");
      }
    }
  }

  Future<void> speak(String text) async {
    _completer = Completer();
    await _flutterTts.speak(text);
    return _completer?.future;
  }
}

// Create a provider to access the TtsService
final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});