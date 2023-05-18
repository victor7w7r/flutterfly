import 'package:injectable/injectable.dart' show PostConstruct, injectable;
import 'package:fpdart/fpdart.dart' show FpdartOnNullable;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

@injectable
final class SharedPrefsModule {

  late final SharedPreferences prefs;
  late final bool cupertinoDark;
  late final bool fluentDark;
  late final bool materialDark;

  @PostConstruct(preResolve: true)
  Future<void> init() async {

    prefs = await SharedPreferences.getInstance();

    prefs.getBool('materialdark').toOption().fold(
      () => prefs.setBool('materialdark', true)
        .then((_) => materialDark = true),
      (dark) => materialDark = dark
    );

    prefs.getBool('cupertinodark').toOption().fold(
      () => prefs.setBool('cupertinodark', true)
        .then((_) => cupertinoDark = true),
      (dark) => cupertinoDark = dark
    );

    prefs.getBool('fluentdark').toOption().fold(
      () => prefs.setBool('fluentdark', true)
        .then((_) => fluentDark = true),
      (dark) => fluentDark = dark
    );

  }
}