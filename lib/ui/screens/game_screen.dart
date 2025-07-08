// lib/ui/screens/game_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/game/hanzi_fusion_game.dart';
import 'package:hanzi_fusion/ui/screens/characters_screen.dart';
import 'package:hanzi_fusion/ui/screens/game_page.dart';
import 'package:hanzi_fusion/ui/screens/recipes_screen.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late final HanziFusionGame _game;
  int _currentIndex = 0;
  final _pages = <Widget>[];

  @override
  void initState() {
    super.initState();
    _game = HanziFusionGame(ref: ref);
    _pages.addAll([
      GamePage(game: _game),
      const CharactersScreen(),
      const RecipesScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final pageTitles = ['Game', 'Characters', 'Recipes'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hanzi Fusion - ${pageTitles[_currentIndex]}'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        ],
      ),
    );
  }
}