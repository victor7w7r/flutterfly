// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binance.riverpod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bitcoinProviderHash() => r'819438086bdec79796a8c9ff0767c7f0109db0b7';

/// See also [bitcoinProvider].
@ProviderFor(bitcoinProvider)
final bitcoinProvider$ = AutoDisposeFutureProvider<Bitcoin>.internal(
  bitcoinProvider,
  name: r'bitcoinProvider$',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bitcoinProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BitcoinProviderRef = AutoDisposeFutureProviderRef<Bitcoin>;
String _$binanceProviderHash() => r'f8d492cf787622b5f004d3ef46553f0928985a43';

/// See also [BinanceProvider].
@ProviderFor(BinanceProvider)
final binanceProvider$ =
    AutoDisposeAsyncNotifierProvider<BinanceProvider, List<Binance>>.internal(
  BinanceProvider.new,
  name: r'binanceProvider$',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$binanceProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BinanceProvider = AutoDisposeAsyncNotifier<List<Binance>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
