import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutterfly/modules/common/providers/desktop_provider.dart';

class DesktopProviderController extends ChangeNotifier {

  DesktopProviderController(this.ref);

  final ChangeNotifierProviderRef ref;
  bool visible = false;

  void toggle() {
    visible = !visible;
    notifyListeners();
  }

  void exit(String selector) {
    toggle();
    Future.delayed(const Duration(seconds: 1), () =>
      ref.read(desktopProvider.notifier).state = selector
    );
  }

}

final desktopSelectorProvider =
  ChangeNotifierProvider<DesktopProviderController>(
    DesktopProviderController.new
  );