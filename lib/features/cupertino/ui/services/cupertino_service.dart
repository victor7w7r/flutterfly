import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart' show lazySingleton;

import 'package:flutterfly/core/modules/localdb_module.dart';

@lazySingleton
class CupertinoService extends ChangeNotifier {
  CupertinoService(this._localDbModule)
      : _isDark = _localDbModule.isCupertinoDark();

  final LocalDbModule _localDbModule;
  bool _isDark;

  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    unawaited(_localDbModule.prefsBox.put('cupertinodark', _isDark));
    notifyListeners();
  }
}
