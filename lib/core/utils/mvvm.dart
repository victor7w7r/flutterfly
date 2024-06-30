import 'package:flutter/material.dart';

import 'package:watch_it/watch_it.dart';

final class ViewModel<T extends Object> extends WatchingWidget {
  const ViewModel({
    required this.builder,
    this.onInit,
    this.onDispose,
    this.disposeLazy = false,
    super.key,
  });

  final Widget Function(T object) builder;
  final void Function(T object)? onInit;
  final void Function(T object)? onDispose;
  final bool disposeLazy;

  @override
  Widget build(final BuildContext context) {
    callOnce(
      (final _) => onInit?.call(GetIt.I.get<T>()),
      dispose: () {
        onDispose?.call(GetIt.I.get<T>());
        // ignore: discarded_futures
        if (disposeLazy) GetIt.I.resetLazySingleton<T>();
      },
    );
    return builder(GetIt.I.get<T>());
  }
}

final class ListenViewModel<T extends ChangeNotifier> extends WatchingWidget {
  const ListenViewModel({
    required this.builder,
    this.onInit,
    this.onDispose,
    this.disposeLazy = false,
    super.key,
  });

  final Widget Function(T notifier) builder;
  final void Function(T notifier)? onInit;
  final void Function(T notifier)? onDispose;
  final bool disposeLazy;

  @override
  Widget build(final BuildContext context) {
    final ctl = watchIt<T>();

    callOnce(
      (final _) => onInit?.call(ctl),
      dispose: () {
        onDispose?.call(ctl);
        // ignore: discarded_futures
        if (disposeLazy) GetIt.I.resetLazySingleton<T>();
      },
    );
    return builder(ctl);
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

  final Widget Function(T not, U obj) builder;
  final void Function(T not, U obj)? onInit;
  final void Function(T not, U obj)? onDispose;
  final bool disposeLazyOne;
  final bool disposeLazyTwo;

  @override
  Widget build(final BuildContext context) {
    final ctl2 = watchIt<U>();

    callOnce(
      (final _) => onInit?.call(
        GetIt.I.get<T>(),
        ctl2,
      ),
      dispose: () {
        onDispose?.call(
          GetIt.I.get<T>(),
          ctl2,
        );
        // ignore: discarded_futures
        if (disposeLazyOne) GetIt.I.resetLazySingleton<T>();
        // ignore: discarded_futures
        if (disposeLazyTwo) GetIt.I.resetLazySingleton<U>();
      },
    );
    return builder(GetIt.I.get<T>(), ctl2);
  }
}
