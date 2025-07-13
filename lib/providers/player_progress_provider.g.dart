// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$availableHintsHash() => r'8fb9404c3e8e9e55a27fe65c210bc98c2a54f40c';

/// A provider that calculates the number of hints the player has available.
///
/// Copied from [availableHints].
@ProviderFor(availableHints)
final availableHintsProvider = AutoDisposeProvider<int>.internal(
  availableHints,
  name: r'availableHintsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableHintsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AvailableHintsRef = AutoDisposeProviderRef<int>;
String _$playerProgressHash() => r'cdae71b931fc3c43ba1e0d0273fe5f7a08c0cda3';

/// See also [PlayerProgress].
@ProviderFor(PlayerProgress)
final playerProgressProvider = AutoDisposeAsyncNotifierProvider<PlayerProgress,
    PlayerProgressData>.internal(
  PlayerProgress.new,
  name: r'playerProgressProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playerProgressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PlayerProgress = AutoDisposeAsyncNotifier<PlayerProgressData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
