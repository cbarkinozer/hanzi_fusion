// lib/ui/widgets/new_discovery_animation.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/models/discovery_model.dart';
import 'package:hanzi_fusion/providers/game_event_provider.dart';
import 'package:hanzi_fusion/providers/tts_provider.dart';

class NewDiscoveryAnimation extends ConsumerStatefulWidget {
  final Discovery discovery;

  const NewDiscoveryAnimation({super.key, required this.discovery});

  @override
  ConsumerState<NewDiscoveryAnimation> createState() =>
      _NewDiscoveryAnimationState();
}

class _NewDiscoveryAnimationState extends ConsumerState<NewDiscoveryAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // Play the animation
    _controller.forward().whenComplete(() {
      _speakDiscovery();
    });
  }

  Future<void> _speakDiscovery() async {
    // This sequence will now work correctly because `tts.speak` waits
    // for the utterance to finish.
    final tts = ref.read(ttsServiceProvider);
    await tts.speak(widget.discovery.input1.pinyin);
    await Future.delayed(const Duration(milliseconds: 250)); // Short pause
    await tts.speak(widget.discovery.input2.pinyin);
    await Future.delayed(const Duration(milliseconds: 250)); // Short pause
    await tts.speak(widget.discovery.output.pinyin);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displayMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: [
        const Shadow(blurRadius: 10, color: Colors.black54)
      ]
    );
    final pinyinStyle = theme.textTheme.headlineSmall?.copyWith(
      fontStyle: FontStyle.italic,
      color: Colors.white.withAlpha(217),
    );
    final englishStyle = theme.textTheme.titleMedium?.copyWith(
      color: Colors.white.withAlpha(180),
    );

    return Stack(
      children: [
        // Background overlay
        FadeTransition(
          opacity: _fadeAnimation,
          child: GestureDetector(
            onTap: () {
              // Allow user to tap to dismiss early
              _controller.reverse().then((_) {
                if (mounted) {
                  ref.read(newDiscoveryProvider.notifier).state = null;
                }
              });
            },
            child: Container(
              color: Colors.black.withAlpha(217),
            ),
          ),
        ),

        // Content
        Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'New Discovery!',
                    style: theme.textTheme.headlineLarge
                        ?.copyWith(color: Colors.amber.shade300, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildCharWithDetails(widget.discovery.input1.char, widget.discovery.input1.pinyin, widget.discovery.input1.meaning, textStyle, pinyinStyle, englishStyle),
                      const SizedBox(width: 24),
                      Text('+', style: textStyle),
                      const SizedBox(width: 24),
                      _buildCharWithDetails(widget.discovery.input2.char, widget.discovery.input2.pinyin, widget.discovery.input2.meaning, textStyle, pinyinStyle, englishStyle),
                      const SizedBox(width: 24),
                      Text('=', style: textStyle),
                      const SizedBox(width: 24),
                      _buildCharWithDetails(widget.discovery.output.char, widget.discovery.output.pinyin, widget.discovery.output.meaning, textStyle, pinyinStyle, englishStyle),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCharWithDetails(String char, String pinyin, String meaning, TextStyle? charStyle, TextStyle? pinyinStyle, TextStyle? englishStyle) {
    return Column(
      children: [
        Text(char, style: charStyle),
        const SizedBox(height: 8),
        Text(pinyin, style: pinyinStyle),
        const SizedBox(height: 4),
        Text('"$meaning"', style: englishStyle),
      ],
    );
  }
}