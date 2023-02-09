import 'package:flutter_riverpod/flutter_riverpod.dart' show Notifier, NotifierProvider;

import 'package:flutterfly/config/index.dart';

class MaterialNotifier extends Notifier<bool> {

  final _app = locator.get<AppConfig>();

  @override
  bool build() => _app.materialDark;

  Future<void> toggle() async {
    state = !state;
    await _app.prefs.setBool('materialdark', state);
  }
}

final materialProvider =
  NotifierProvider<MaterialNotifier, bool>(
    MaterialNotifier.new
  );