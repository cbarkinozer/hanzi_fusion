import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

// A simple model for our settings
class SettingsData {
  final bool sfxEnabled;
  final bool musicEnabled;

  const SettingsData({this.sfxEnabled = true, this.musicEnabled = true});

  SettingsData copyWith({bool? sfxEnabled, bool? musicEnabled}) {
    return SettingsData(
      sfxEnabled: sfxEnabled ?? this.sfxEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
        'sfxEnabled': sfxEnabled,
        'musicEnabled': musicEnabled,
      };

  factory SettingsData.fromJson(Map<String, dynamic> json) => SettingsData(
        sfxEnabled: json['sfxEnabled'] as bool,
        musicEnabled: json['musicEnabled'] as bool,
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
      return SettingsData.fromJson(json.decode(jsonString));
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
}