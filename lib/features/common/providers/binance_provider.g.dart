// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binance_provider.dart';

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
String _$binanceProviderHash() => r'8eda64a271fa1f3db358024d54c3a66d36e79088';

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
