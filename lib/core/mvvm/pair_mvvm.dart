import 'package:flutter/material.dart';

import 'package:watch_it/watch_it.dart';

final class PairViewModel<T extends Object, U extends Object>
    extends WatchingWidget {
  const PairViewModel({
    required this.builder,
    this.onInit,
    this.onDispose,
    this.disposeLazyOne = false,
    this.disposeLazyTwo = false,
    super.key,
  });

  final Widget Function(T, U) builder;
  final void Function()? onInit;
  final void Function()? onDispose;
  final bool disposeLazyOne;
  final bool disposeLazyTwo;

  @override
  Widget build(final BuildContext context) {
    callOnce(
      (final _) => onInit?.call(),
      dispose: () {
        onDispose?.call();
        // ignore: discarded_futures
        if (disposeLazyOne) GetIt.I.resetLazySingleton<T>();
        // ignore: discarded_futures
        if (disposeLazyTwo) GetIt.I.resetLazySingleton<U>();
      },
    );
    return builder(
      GetIt.I.get<T>(),
      GetIt.I.get<U>(),
    );
  }
}

final class PairListenViewModel<T extends ChangeNotifier,
    U extends ChangeNotifier> extends WatchingWidget {
  const PairListenViewModel({
    required this.builder,
    this.onInit,
    this.onDispose,
    this.disposeLazyOne = false,
    this.disposeLazyTwo = false,
    super.key,
  });

  final Widget Function(T, U) builder;
  final void Function()? onInit;
  final void Function()? onDispose;
  final bool disposeLazyOne;
  final bool disposeLazyTwo;

  @override
  Widget build(final BuildContext context) {
    final ctl1 = watchIt<T>();
    final ctl2 = watchIt<U>();

    callOnce(
      (final _) => onInit?.call(),
      dispose: () {
        onDispose?.call();
        // ignore: discarded_futures
        if (disposeLazyOne) GetIt.I.resetLazySingleton<T>();
        // ignore: discarded_futures
        if (disposeLazyTwo) GetIt.I.resetLazySingleton<U>();
      },
    );
    return builder(ctl1, ctl2);
  }
}

final class LUViewModel<T extends Object, U extends ChangeNotifier>
    extends WatchingWidget {
  const LUViewModel({
    required this.builder,
    this.onInit,
    this.onDispose,
    this.disposeLazyOne = false,
    this.disposeLazyTwo = false,
    super.key,
  });

  final Widget Function(T, U) builder;
  final void Function()? onInit;
  final void Function()? onDispose;
  final bool disposeLazyOne;
  final bool disposeLazyTwo;

  @override
  Widget build(final BuildContext context) {
    final ctl2 = watchIt<U>();

    callOnce(
      (final _) => onInit?.call(),
      dispose: () {
        onDispose?.call();
        // ignore: discarded_futures
        if (disposeLazyOne) GetIt.I.resetLazySingleton<T>();
        // ignore: discarded_futures
        if (disposeLazyTwo) GetIt.I.resetLazySingleton<U>();
      },
    );
    return builder(GetIt.I.get<T>(), ctl2);
  }
}
