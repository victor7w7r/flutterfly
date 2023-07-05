import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

part 'prefs_module.g.dart';

class PrefsModule {

  final SharedPreferences _prefs;

  PrefsModule(this._prefs);

  bool _darkWorker(final String key) {
    final isDark = _prefs.getBool(key);
    if(isDark == null) {
      _prefs.setBool(key, true);
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
SharedPreferences sharedPrefs(
  final SharedPrefsRef ref
) => throw UnimplementedError();

@Riverpod(keepAlive: true)
PrefsModule prefsModule(
  final PrefsModuleRef ref
) => PrefsModule(
  ref.read(sharedPrefs$)
);

PrefsModule prefsRef<T extends Ref>(
  final T ref
) => ref.read(prefsModule$);