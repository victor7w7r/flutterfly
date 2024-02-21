import 'dart:async' show Timer;

import 'package:fluent_ui/fluent_ui.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/modules/prefs.module.dart';

part 'fluent.riverpod.g.dart';

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

@riverpod
final class FluentProvider extends _$FluentProvider {
  @override
  FluentThemeApp build() => ref.read(prefsModule$).fluentDark
      ? FluentThemeApp.dark()
      : FluentThemeApp.light();

  void interpolator(final List<Color> changer) {
    var linear = 0.1;
    Color interpolatorBack;
    Color interpolatorCard;
    Color interpolatorInv;

    Timer.periodic(const Duration(milliseconds: 30), (final t) {
      interpolatorBack = Color.lerp(state.themeColor[0], changer[0], linear)!;
      interpolatorCard = Color.lerp(state.themeColor[1], changer[1], linear)!;
      interpolatorInv = Color.lerp(state.themeColor[2], changer[2], linear)!;
      state = state.copyWith(
        themeColor: [interpolatorBack, interpolatorCard, interpolatorInv],
      );
      linear += 0.1;
      if (linear >= 1) t.cancel();
    });
  }

  Future<void> toggle(final bool value) async {
    state = state.copyWith(isDark: value);
    state.isDark ? interpolator(darkColors) : interpolator(lightColors);
    await ref.read(sharedPrefs$).setBool('fluentdark', state.isDark);
  }
}

@riverpod
bool fluentIsDarkProvider(
  final FluentIsDarkProviderRef ref,
) =>
    ref.watch(fluentProvider$).isDark;
