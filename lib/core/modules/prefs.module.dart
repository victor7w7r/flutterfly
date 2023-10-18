import 'dart:async' show unawaited;

import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

part 'prefs.module.g.dart';

final class PrefsModule {
  const PrefsModule(this._prefs);

  final SharedPreferences _prefs;

  bool _darkWorker(final String key) {
    final isDark = _prefs.getBool(key);
    if (isDark == null) {
      unawaited(_prefs.setBool(key, true));
      return true;
    } else {
      return isDark;
    }
  }

  bool get materialDark => _darkWorker('materialdark');
  bool get cupertinoDark => _darkWorker('cupertinodark');
  bool get fluentDark => _darkWorker('fluentdark');
}

@riverpod
SharedPreferences sharedPrefs(final SharedPrefsRef ref) =>
    throw UnimplementedError();

@Riverpod(keepAlive: true)
PrefsModule prefsModule(final PrefsModuleRef ref) =>
    PrefsModule(ref.read(sharedPrefs$));

PrefsModule prefsRef<T extends Ref>(final T ref) => ref.read(prefsModule$);
