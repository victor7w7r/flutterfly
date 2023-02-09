import 'package:flutter_riverpod/flutter_riverpod.dart' show Notifier, NotifierProvider;

import 'package:flutterfly/config/index.dart';

class CupertinoNotifier extends Notifier<bool> {

  final _app = locator.get<AppConfig>();

  @override
  bool build() => _app.cupertinoDark;

  Future<void> toggle() async {
    state = !state;
    await _app.prefs.setBool('cupertinodark', state);
  }
}

final cupertinoProvider =
  NotifierProvider<CupertinoNotifier, bool>(
    CupertinoNotifier.new
  );