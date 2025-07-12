// lib/providers/game_event_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_fusion/data/models/discovery_model.dart';

/// This provider holds the most recently discovered recipe.
/// The UI can watch this to trigger a "New Discovery" animation.
/// It should be reset to null after the animation is shown.
final newDiscoveryProvider = StateProvider<Discovery?>((ref) => null);