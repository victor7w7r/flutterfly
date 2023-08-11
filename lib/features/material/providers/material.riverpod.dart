import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/modules/prefs.module.dart';

part 'material.riverpod.g.dart';

@riverpod
final class MaterialProvider
  extends _$MaterialProvider {

  @override
  bool build() =>
    ref.read(prefsModule$).materialDark;

  Future<void> toggle() async {
    state = !state;
    await ref.read(sharedPrefs$)
      .setBool('materialdark', state);
  }
}
