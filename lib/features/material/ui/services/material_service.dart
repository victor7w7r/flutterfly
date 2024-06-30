import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart' show lazySingleton;

import 'package:flutterfly/core/modules/localdb_module.dart';

@lazySingleton
final class MaterialService extends ChangeNotifier {
  MaterialService(this._localDbModule)
      : _isDark = _localDbModule.isMaterialDark;

  bool _isDark;
  final LocalDbModule _localDbModule;

  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    unawaited(_localDbModule.prefsBox.put('materialdark', _isDark));
    notifyListeners();
  }
}
