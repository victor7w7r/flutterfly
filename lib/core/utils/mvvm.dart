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

  final Widget Function(T) builder;
  final void Function(T)? onInit;
  final void Function(T)? onDispose;
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

  final Widget Function(T) builder;
  final void Function(T)? onInit;
  final void Function(T)? onDispose;
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
