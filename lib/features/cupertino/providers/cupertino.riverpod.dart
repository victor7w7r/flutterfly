import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/modules/localdb_module.dart';

part 'cupertino.riverpod.g.dart';

@riverpod
final class CupertinoProvider extends _$CupertinoProvider {
  @override
  bool build() => ref.read(prefsModule$).cupertinoDark;

  Future<void> toggle() async {
    state = !state;
    await ref.read(sharedPrefs$).setBool('cupertinodark', state);
  }
}
