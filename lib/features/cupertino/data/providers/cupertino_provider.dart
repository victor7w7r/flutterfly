import 'package:flutter_riverpod/flutter_riverpod.dart' show Notifier, NotifierProvider;

import 'package:flutterfly/config/inject/inject.dart';
import 'package:flutterfly/core/modules/shareprefs_module.dart';

class CupertinoNotifier
  extends Notifier<bool> {

  @override
  bool build() =>
    inject.get<SharedPrefsModule>().cupertinoDark;

  Future<void> toggle() async {
    state = !state;
    await inject.get<SharedPrefsModule>()
      .prefs.setBool('cupertinodark', state);
  }
}

final cupertinoProvider =
  NotifierProvider<CupertinoNotifier, bool>(
    CupertinoNotifier.new
  );