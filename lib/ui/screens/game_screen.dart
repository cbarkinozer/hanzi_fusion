// lib/ui/screens/game_screen.dart
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/game/hanzi_fusion_game.dart';
import 'package:hanzi_fusion/providers/level_provider.dart';
import 'package:hanzi_fusion/providers/player_progress_provider.dart';
import 'package:hanzi_fusion/providers/settings_provider.dart';
import 'package:hanzi_fusion/ui/screens/characters_screen.dart';
import 'package:hanzi_fusion/ui/screens/game_page.dart';
import 'package:hanzi_fusion/ui/screens/recipes_screen.dart';
import 'package:hanzi_fusion/ui/screens/settings_screen.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late final HanziFusionGame _game;
  int _currentIndex = 0;
  final _pages = <Widget>[];

  final _pageTitles = ['Game', 'Characters', 'Recipes', 'Settings'];

  @override
  void initState() {
    super.initState();
    _game = HanziFusionGame(ref: ref);
    _pages.addAll([
      GamePage(game: _game),
      const CharactersScreen(),
      const RecipesScreen(),
      const SettingsScreen(),
    ]);
    
    Future.microtask(() async {
      await FlameAudio.audioCache.loadAll(['levelup.mp3', 'background_music.mp3']);
      final settings = await ref.read(settingsProvider.future);
      if (settings.musicEnabled) {
        // MODIFIED: Lowered initial volume
        FlameAudio.bgm.play('background_music.mp3', volume: 0.2);
      }
    });
  }
  
  @override
  void dispose() {
    FlameAudio.bgm.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final levels = ref.watch(levelsProvider);
    
    ref.listen(settingsProvider, (previous, next) {
      final musicEnabled = next.value?.musicEnabled ?? false;
      if (musicEnabled) {
        // MODIFIED: Lowered resume volume
        FlameAudio.bgm.play('background_music.mp3', volume: 0.2);
      } else {
        FlameAudio.bgm.stop();
      }
    });

    ref.listen(playerProgressProvider, (previous, next) {
      final sfxEnabled = ref.read(settingsProvider).value?.sfxEnabled ?? true;
      if (!sfxEnabled || levels.isEmpty || previous?.value == null || next.value == null) return;

      int getHighestLevel(Set<int> ids) {
        int highest = 0;
        for (final level in levels) {
          if (level.characterIds.any((id) => ids.contains(id))) {
            if (level.level > highest) highest = level.level;
          }
        }
        return highest;
      }

      final oldLevel = getHighestLevel(previous!.value!.discoveredCharacterIds);
      final newLevel = getHighestLevel(next.value!.discoveredCharacterIds);

      if (newLevel > oldLevel) {
        FlameAudio.play('levelup.mp3', volume: 0.7);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Level Up! Reached ${levels[newLevel].name}.'),
            backgroundColor: levels[newLevel].themeColor,
          ),
        );
      }
    });
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Hanzi Fusion - ${_pageTitles[_currentIndex]}'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
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
  }
}