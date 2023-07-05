import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/modules/prefs_module.dart';

part 'material_provider.g.dart';

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