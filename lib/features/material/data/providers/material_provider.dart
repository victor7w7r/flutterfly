import 'package:flutter_riverpod/flutter_riverpod.dart' show Notifier, NotifierProvider;

import 'package:flutterfly/config/inject/inject.dart';
import 'package:flutterfly/core/modules/shareprefs_module.dart';

final class MaterialNotifier
  extends Notifier<bool> {

  @override
  bool build() =>
    inject.get<SharedPrefsModule>().materialDark;

  Future<void> toggle() async {
    state = !state;
    await inject.get<SharedPrefsModule>()
      .prefs.setBool('materialdark', state);
  }
}

final materialProvider =
  NotifierProvider<MaterialNotifier, bool>(
    MaterialNotifier.new
  );