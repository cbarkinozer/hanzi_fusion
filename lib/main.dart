// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/providers/theme_provider.dart';
import 'package:hanzi_fusion/ui/screens/game_screen.dart';

void main() {
  // Ensure that Flutter bindings are initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

// MODIFIED: Converted to a ConsumerWidget to access providers
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme provider for color changes
    final themeColor = ref.watch(appThemeColorProvider);

    return MaterialApp(
      title: 'Hanzi Fusion',
      theme: ThemeData(
        fontFamily: 'NotoSansSC', // Set default font for the entire app
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeColor, // Use the dynamic theme color
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}