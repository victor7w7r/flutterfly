import 'dart:async' show Timer, unawaited;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:injectable/injectable.dart' show lazySingleton;

import 'package:flutterfly/core/modules/localdb_module.dart';

final List<Color> darkColors = [
  Colors.black,
  const Color.fromARGB(255, 42, 52, 68),
  Colors.white,
];

final List<Color> lightColors = [
  Colors.white,
  const Color.fromARGB(255, 42, 52, 68),
  Colors.black,
];

final class FluentThemeApp {
  const FluentThemeApp(this.isDark, this.themeColor);

  factory FluentThemeApp.dark() => FluentThemeApp(true, darkColors);

  factory FluentThemeApp.light() => FluentThemeApp(false, lightColors);

  final bool isDark;
  final List<Color> themeColor;

  FluentThemeApp copyWith({
    final bool? isDark,
    final List<Color>? themeColor,
  }) =>
      FluentThemeApp(isDark ?? this.isDark, themeColor ?? this.themeColor);
}

@lazySingleton
class FluentService extends ChangeNotifier {
  FluentService(this._localDbModule)
      : _state = _localDbModule.isFluentDark()
            ? FluentThemeApp.dark()
            : FluentThemeApp.light();

  final LocalDbModule _localDbModule;
  FluentThemeApp _state;

  set mutate(final FluentThemeApp value) {
    _state = value;
    notifyListeners();
  }

  FluentThemeApp get state => _state;

  void interpolator(final List<Color> changer) {
    var linear = 0.1;
    Color interpolatorBack;
    Color interpolatorCard;
    Color interpolatorInv;

    Timer.periodic(const Duration(milliseconds: 30), (final t) {
      interpolatorBack =
          Color.lerp(state.themeColor.first, changer.first, linear) ??
              Colors.white;
      interpolatorCard =
          Color.lerp(state.themeColor[1], changer[1], linear) ?? Colors.white;
      interpolatorInv =
          Color.lerp(state.themeColor[2], changer[2], linear) ?? Colors.white;
      mutate = state.copyWith(
        themeColor: [interpolatorBack, interpolatorCard, interpolatorInv],
      );
      linear += 0.1;
      if (linear >= 1) t.cancel();
    });
  }

  Future<void> toggle(final bool value) async {
    mutate = state.copyWith(isDark: value);
    state.isDark ? interpolator(darkColors) : interpolator(lightColors);
    unawaited(_localDbModule.prefsBox.put('fluentdark', state.isDark));
  }
}
