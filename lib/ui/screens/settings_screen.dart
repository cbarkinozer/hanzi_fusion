// lib/ui/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';
import 'package:hanzi_fusion/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return settings.when(
      data: (data) => ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Sound Effects (SFX)'),
            value: data.sfxEnabled,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleSfx();
            },
            secondary: const Icon(Icons.volume_up_outlined),
          ),
          SwitchListTile(
            title: const Text('Music'),
            value: data.musicEnabled,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleMusic();
            },
            secondary: const Icon(Icons.music_note_outlined),
          ),
          SwitchListTile(
            title: const Text('Pronunciation (TTS)'),
            subtitle: const Text('Read out new discoveries'),
            value: data.ttsEnabled,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleTts();
            },
            secondary: const Icon(Icons.record_voice_over_outlined),
          ),
          const Divider(height: 40),
          FilledButton.tonal(
            onPressed: () => _confirmReset(context, ref),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer
            ),
            child: const Text('Reset All Progress'),
          ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Reset'),
          content: const Text('Are you sure you want to reset all your discovered characters and recipes? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                ref.read(playerProgressProvider.notifier).resetProgress();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Progress has been reset.')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}