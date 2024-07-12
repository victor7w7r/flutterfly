import 'package:flutter/widgets.dart' show ChangeNotifier;

import 'package:injectable/injectable.dart' show lazySingleton;

import 'package:flutterfly/features/common/ui/services/desktop_service.dart';

@lazySingleton
class DesktopSelectorController extends ChangeNotifier {
  DesktopSelectorController(this._desktopService) : _isinitAnim = false;

  final DesktopService _desktopService;
  bool _isinitAnim;

  bool get isInitAnim => _isinitAnim;

  set isinitAnim(final bool value) {
    _isinitAnim = value;
    notifyListeners();
  }

  void exit(final String selector) {
    isinitAnim = false;
    Future.delayed(
      const Duration(seconds: 1),
      () => _desktopService.mutate = selector,
    );
  }

  void init() => Future.delayed(Duration.zero, () => isinitAnim = true);
}
