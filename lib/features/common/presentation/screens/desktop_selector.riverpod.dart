import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/features/common/providers/desktop.riverpod.dart';

part 'desktop_selector.riverpod.g.dart';

@riverpod
final class DesktopSelectorController extends _$DesktopSelectorController {
  @override
  bool build() {
    Future.delayed(Duration.zero, () => state = true);
    return false;
  }

  void exit(final String selector) {
    state = !state;
    Future.delayed(
      const Duration(seconds: 1),
      () => ref.read(desktopProvider$.notifier).state = selector,
    );
  }
}
