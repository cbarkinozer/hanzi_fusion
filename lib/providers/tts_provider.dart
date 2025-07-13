// lib/providers/tts_provider.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();
  Completer? _completer;

  TtsService() {
    _initTts();
  }

  Future<void> _initTts() async {
    _flutterTts.setCompletionHandler(() {
      _completer?.complete();
      _completer = null;
    });

    _flutterTts.setErrorHandler((msg) {
      if (kDebugMode) {
        print("TTS Error: $msg");
      }
      _completer?.completeError(msg);
      _completer = null;
    });

    if (!kIsWeb) {
      await _setChineseVoice();
    }

    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> _setChineseVoice() async {
    try {
      List<dynamic> voices = await _flutterTts.getVoices;
      Map<String, String>? selectedVoice;

      for (var v in voices.cast<Map<String, String>>()) {
        final locale = v['locale'] ?? '';
        if (locale == 'zh-CN') {
          selectedVoice = v;
          break;
        }
        if (locale.startsWith('zh-')) {
          selectedVoice ??= v;
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
    if (kIsWeb) {
      final encodedText = Uri.encodeComponent(text);
      
      // UPDATED: Smart URL selection
      // During local development (kDebugMode), we use the full URL to the vercel dev server.
      // In production on Vercel, we use a relative path which works automatically.
      final String baseUrl = kDebugMode ? 'http://localhost:3000' : '';
      final url = '$baseUrl/api/tts?text=$encodedText';

      if (kDebugMode) {
        print('Requesting TTS from: $url');
      }

      await _audioPlayer.play(UrlSource(url));
      return _audioPlayer.onPlayerComplete.first;
    } 
    else {
      _completer = Completer();
      await _flutterTts.speak(text);
      return _completer?.future;
    }
  }
}

final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});