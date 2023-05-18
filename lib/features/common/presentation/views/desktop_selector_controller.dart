import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutterfly/features/common/data/providers/desktop_provider.dart';

final class DesktopProviderController
  extends ChangeNotifier {

  final ChangeNotifierProviderRef _ref;
  bool _visible;

  DesktopProviderController(this._ref):
    _visible = false;

  void exit(final String selector) {
    visible = !_visible;
    Future.delayed(
      const Duration(seconds: 1),
      () => _ref.read(desktopProvider.notifier)
        .state = selector
    );
  }

  bool get visible => _visible;

  set visible(final bool value) {
    _visible = value;
    notifyListeners();
  }

}

final desktopSelectorProvider =
  ChangeNotifierProvider<DesktopProviderController>(
    DesktopProviderController.new
  );