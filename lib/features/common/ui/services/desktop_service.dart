import 'package:flutter/widgets.dart' show ChangeNotifier;

import 'package:injectable/injectable.dart' show lazySingleton;

@lazySingleton
class DesktopService extends ChangeNotifier {
  DesktopService() : _state = 'none';

  String _state;

  set mutate(final String state) {
    _state = state;
    notifyListeners();
  }

  String get state => _state;
}
