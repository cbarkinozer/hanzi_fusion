// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$availableHintsHash() => r'5b5fc58b5b6c31e2355bbc78d827ce58a42a1e29';

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
String _$hintProgressHash() => r'a2921eb1e8eb878069b2815cf454be5fc01bf413';

/// See also [hintProgress].
@ProviderFor(hintProgress)
final hintProgressProvider = AutoDisposeProvider<int>.internal(
  hintProgress,
  name: r'hintProgressProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$hintProgressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HintProgressRef = AutoDisposeProviderRef<int>;
String _$playerProgressHash() => r'e0738787fff11b95eb8000a434e8d43116ec6fe4';

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
