// lib/ui/screens/game_screen.dart
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';
import 'package:hanzi_fusion/game/hanzi_fusion_game.dart';
import 'package:hanzi_fusion/providers/game_event_provider.dart';
import 'package:hanzi_fusion/providers/level_provider.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';
import 'package:hanzi_fusion/providers/settings_provider.dart';
import 'package:hanzi_fusion/ui/screens/characters_screen.dart';
import 'package:hanzi_fusion/ui/screens/game_page.dart';
import 'package:hanzi_fusion/ui/screens/recipes_screen.dart';
import 'package:hanzi_fusion/ui/screens/settings_screen.dart';
import 'package:hanzi_fusion/ui/widgets/new_discovery_animation.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  HanziFusionGame? _game;
  int _currentIndex = 0;
  List<Widget> _pages = [];

  final _pageTitles = ['Game', 'Characters', 'Recipes', 'Settings'];
  
  @override
  void initState() {
    super.initState();
    FlameAudio.audioCache.loadAll(['levelup.mp3', 'background_music.mp3']);
  }

  @override
  void dispose() {
    FlameAudio.bgm.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameDataAsync = ref.watch(gameDataRepositoryProvider);

    return gameDataAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Hanzi Fusion')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Failed to load game data: $err')),
      ),
      data: (_) {
        if (_game == null) {
          _game = HanziFusionGame(ref: ref);
          _pages = [
            GamePage(game: _game!),
            const CharactersScreen(),
            const RecipesScreen(),
            const SettingsScreen(),
          ];

          Future.microtask(() async {
            final settings = await ref.read(settingsProvider.future);
            if (settings.musicEnabled && !FlameAudio.bgm.isPlaying) {
              FlameAudio.bgm.play('background_music.mp3', volume: 0.2);
            }
          });
        }
        
        final levels = ref.watch(levelsProvider);
        ref.listen(settingsProvider, (previous, next) {
          final musicEnabled = next.value?.musicEnabled ?? false;
          if (musicEnabled) {
            if (!FlameAudio.bgm.isPlaying) {
               FlameAudio.bgm.play('background_music.mp3', volume: 0.2);
            }
          } else {
            FlameAudio.bgm.stop();
          }
        });

        ref.listen(playerProgressProvider, (previous, next) {
          final sfxEnabled = ref.read(settingsProvider).value?.sfxEnabled ?? true;
          if (!sfxEnabled || levels.isEmpty || previous?.value == null || next.value == null) return;
          final prevDiscoveredIds = previous!.value!.discoveredCharacterIds.toSet();
          final nextDiscoveredIds = next.value!.discoveredCharacterIds.toSet();
          if (nextDiscoveredIds.length <= prevDiscoveredIds.length) return;
          for (final level in levels) {
            final allInLevelDiscovered = level.characterIds.every((id) => nextDiscoveredIds.contains(id));
            final wasNotCompleteBefore = !level.characterIds.every((id) => prevDiscoveredIds.contains(id));
            if (allInLevelDiscovered && wasNotCompleteBefore) {
              FlameAudio.play('levelup.mp3', volume: 0.7);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Level Complete! You finished ${level.name}.'),
                  backgroundColor: level.themeColor,
                ),
              );
            }
          }
        });

        final lastDiscovery = ref.watch(newDiscoveryProvider);

        return Scaffold(
          appBar: AppBar(
            title: Text('Hanzi Fusion - ${_pageTitles[_currentIndex]}'),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
              if (lastDiscovery != null)
                NewDiscoveryAnimation(discovery: lastDiscovery),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.gamepad_outlined),
                activeIcon: Icon(Icons.gamepad),
                label: 'Game',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined),
                activeIcon: Icon(Icons.book),
                label: 'Characters',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}