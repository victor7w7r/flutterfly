import 'package:flutter/widgets.dart' show ChangeNotifier;

import 'package:injectable/injectable.dart' show lazySingleton;

@lazySingleton
class DataService extends ChangeNotifier {
  DataService() : _state = '';

  String _state;

  set mutate(final String state) {
    _state = state;
    notifyListeners();
  }

  String get state => _state;
}
