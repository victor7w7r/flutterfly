import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:flutterfly/features/common/ui/services/desktop_service.dart';

import 'package:injectable/injectable.dart' show lazySingleton;

@lazySingleton
final class DesktopSelectorController extends ChangeNotifier {
  DesktopSelectorController(this._desktopService) : _initAnim = false;

  final DesktopService _desktopService;
  bool _initAnim;

  void init() => Future.delayed(Duration.zero, () => initAnim = true);

  void exit(final String selector) {
    initAnim = false;
    Future.delayed(
      const Duration(seconds: 1),
      () => _desktopService.mutate = selector,
    );
  }

  bool get initAnim => _initAnim;

  set initAnim(final bool value) {
    _initAnim = value;
    notifyListeners();
  }
}
