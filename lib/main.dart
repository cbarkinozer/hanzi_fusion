import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/game_data_repository.dart';

void main() {
  // We need to wrap our app in a ProviderScope to use Riverpod.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hanzi Fusion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2A9D8F),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch our new provider
    final gameDataAsync = ref.watch(gameDataRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hanzi Fusion - Data Loading'),
      ),
      // The provider gives us a clean way to handle loading/error/data states.
      body: gameDataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (gameData) {
          // If data is loaded successfully, show a confirmation message.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 80),
                const SizedBox(height: 20),
                Text(
                  'Data Loaded Successfully!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text('Found ${gameData.characters.length} characters.'),
                Text('Found ${gameData.recipes.length} recipes.'),
              ],
            ),
          );
        },
      ),
    );
  }
}