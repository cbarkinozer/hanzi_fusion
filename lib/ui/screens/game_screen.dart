// lib/ui/screens/game_screen.dart
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart'; // Yükleme durumunu kontrol etmek için eklendi
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
  // DÜZELTME: Oyun nesnesini 'late final' yapmıyoruz, çünkü veri yüklendikten sonra oluşturacağız.
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
    // --- DÜZELTME BAŞLANGICI: Tüm oyun mantığı bu yükleme kontrolünün içine alındı ---

    // 1. Temel oyun verisinin yüklenip yüklenmediğini izle
    final gameDataAsync = ref.watch(gameDataRepositoryProvider);

    return gameDataAsync.when(
      // 2. Veri yüklenirken ekranda bir yükleme animasyonu göster
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Hanzi Fusion')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      // Hata olursa hata mesajı göster
      error: (err, stack) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Failed to load game data: $err')),
      ),
      // 3. Veri başarıyla yüklendiyse, oyun arayüzünü oluştur
      data: (_) {
        // Oyun nesnesini sadece bir kez, veri yüklendikten sonra oluştur
        if (_game == null) {
          _game = HanziFusionGame(ref: ref);
          _pages = [
            GamePage(game: _game!),
            const CharactersScreen(),
            const RecipesScreen(),
            const SettingsScreen(),
          ];

          // Müziği burada başlat
          Future.microtask(() async {
            final settings = await ref.read(settingsProvider.future);
            if (settings.musicEnabled && !FlameAudio.bgm.isPlaying) {
              FlameAudio.bgm.play('background_music.mp3', volume: 0.2);
            }
          });
        }
        
        // Müzik ve seviye atlama seslerini dinleyen mantık buraya taşındı
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
      },
    );
    // --- DÜZELTME SONU ---
  }
}