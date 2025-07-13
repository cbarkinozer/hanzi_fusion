import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

// A simple model for our settings
class SettingsData {
  final bool sfxEnabled;
  final bool musicEnabled;
  final bool ttsEnabled;

  const SettingsData({
    this.sfxEnabled = true,
    this.musicEnabled = true,
    this.ttsEnabled = true,
  });

  SettingsData copyWith({
    bool? sfxEnabled,
    bool? musicEnabled,
    bool? ttsEnabled,
  }) {
    return SettingsData(
      sfxEnabled: sfxEnabled ?? this.sfxEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      ttsEnabled: ttsEnabled ?? this.ttsEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
        'sfxEnabled': sfxEnabled,
        'musicEnabled': musicEnabled,
        'ttsEnabled': ttsEnabled,
      };

  factory SettingsData.fromJson(Map<String, dynamic> json) => SettingsData(
        sfxEnabled: json['sfxEnabled'] as bool? ?? true,
        musicEnabled: json['musicEnabled'] as bool? ?? true,
        ttsEnabled: json['ttsEnabled'] as bool? ?? true,
      );
}


@riverpod
class Settings extends _$Settings {
  late SharedPreferences _prefs;
  static const _settingsKey = 'appSettings';

  @override
  Future<SettingsData> build() async {
    ref.keepAlive();
    _prefs = await SharedPreferences.getInstance();
    final jsonString = _prefs.getString(_settingsKey);
    if (jsonString != null) {
      try {
        return SettingsData.fromJson(json.decode(jsonString));
      } catch (_) {
        // If parsing fails, return default.
        return const SettingsData();
      }
    }
    return const SettingsData(); // Return default settings
  }

  Future<void> _save(SettingsData data) async {
    state = AsyncData(data);
    await _prefs.setString(_settingsKey, json.encode(data.toJson()));
  }

  Future<void> toggleSfx() async {
    final currentSettings = state.value ?? const SettingsData();
    await _save(currentSettings.copyWith(sfxEnabled: !currentSettings.sfxEnabled));
  }

  Future<void> toggleMusic() async {
    final currentSettings = state.value ?? const SettingsData();
    await _save(currentSettings.copyWith(musicEnabled: !currentSettings.musicEnabled));
  }

  Future<void> toggleTts() async {
    final currentSettings = state.value ?? const SettingsData();
    await _save(currentSettings.copyWith(ttsEnabled: !currentSettings.ttsEnabled));
  }
}