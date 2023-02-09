import 'dart:async' show Timer;

import 'package:flutter/widgets.dart' show Color;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/config/index.dart';

class FluentThemeApp {

  FluentThemeApp(this.darkMode, this.themeColor);

  factory FluentThemeApp.dark() => FluentThemeApp(
    true, [TWColors.gray.shade900, TWColors.gray.shade800, TWColors.gray.shade100]
  );

  factory FluentThemeApp.light() => FluentThemeApp(
    false, [TWColors.gray.shade100, TWColors.gray.shade400, TWColors.gray.shade900]
  );

  final bool darkMode;
  final List<Color> themeColor;

  FluentThemeApp copyWith({bool? darkMode, List<Color>? themeColor}) => FluentThemeApp(
    darkMode ?? this.darkMode,
    themeColor ?? this.themeColor
  );
}

class FluentNotifier extends Notifier<FluentThemeApp> {

  final _app = locator.get<AppConfig>();

  @override
  FluentThemeApp build() => _app.fluentDark
    ? FluentThemeApp.dark()
    : FluentThemeApp.light();

  void interpolator(List<Color> changer) {

    double linear = 0.1;
    Color interpolatorBack;
    Color interpolatorCard;
    Color interpolatorInv;

    Timer.periodic(const Duration(milliseconds: 30), (t) {
      interpolatorBack = Color.lerp(state.themeColor[0], changer[0], linear)!;
      interpolatorCard = Color.lerp(state.themeColor[1], changer[1], linear)!;
      interpolatorInv = Color.lerp(state.themeColor[2], changer[2], linear)!;
      state = state.copyWith(themeColor: [interpolatorBack, interpolatorCard, interpolatorInv]);
      linear += 0.1;
      if(linear >= 1) t.cancel();
    });
  }

  Future<void> toggle(bool value) async {
    state = state.copyWith(darkMode: value);
    state.darkMode
      ? interpolator([TWColors.gray.shade900, TWColors.gray.shade800, TWColors.gray.shade100])
      : interpolator([TWColors.gray.shade100, TWColors.gray.shade400, TWColors.gray.shade900]);
    await _app.prefs.setBool('fluentdark', state.darkMode);
  }
}

final fluentProvider =
  NotifierProvider<FluentNotifier, FluentThemeApp>(
    FluentNotifier.new
  );

final fluentIsDarkProvider = Provider<bool>(
  (ref) => ref.watch(fluentProvider).darkMode
);