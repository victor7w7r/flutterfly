import 'dart:async' show Timer;

import 'package:flutter/widgets.dart' show Color;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/core/modules/prefs_module.dart';

part 'fluent_provider.g.dart';

final List<Color> darkColors = [
  TWColors.gray.shade900,
  TWColors.gray.shade800,
  TWColors.gray.shade100
];

final List<Color> lightColors = [
  TWColors.gray.shade100,
  TWColors.gray.shade400,
  TWColors.gray.shade900
];

final class FluentThemeApp {

  final bool isDark;
  final List<Color> themeColor;

  const FluentThemeApp(this.isDark, this.themeColor);

  factory FluentThemeApp.dark() => FluentThemeApp(
    true, darkColors
  );

  factory FluentThemeApp.light() => FluentThemeApp(
    false, lightColors
  );

  FluentThemeApp copyWith({
    bool? isDark,
    List<Color>? themeColor
  }) => FluentThemeApp(
    isDark ?? this.isDark,
    themeColor ?? this.themeColor
  );
}

@riverpod
final class FluentProvider
  extends _$FluentProvider {

  @override
  FluentThemeApp build() =>
    ref.read(prefsModule$).fluentDark
      ? FluentThemeApp.dark()
      : FluentThemeApp.light();

  void interpolator(
    final List<Color> changer
  ) {

    double linear = 0.1;
    Color interpolatorBack;
    Color interpolatorCard;
    Color interpolatorInv;

    Timer.periodic(const Duration(milliseconds: 30), (t) {
      interpolatorBack = Color.lerp(
        state.themeColor[0], changer[0], linear
      )!;
      interpolatorCard = Color.lerp(
        state.themeColor[1], changer[1], linear
      )!;
      interpolatorInv = Color.lerp(
        state.themeColor[2], changer[2], linear
      )!;
      state = state.copyWith(themeColor: [
        interpolatorBack, interpolatorCard, interpolatorInv
      ]);
      linear += 0.1;
      if(linear >= 1) t.cancel();
    });
  }

  Future<void> toggle(
    final bool value
  ) async {
    state = state.copyWith(isDark: value);
    state.isDark
      ? interpolator(darkColors)
      : interpolator(lightColors);
    await ref.read(sharedPrefs$)
      .setBool('fluentdark', state.isDark);
  }
}

@riverpod
bool fluentIsDarkProvider(
  final FluentIsDarkProviderRef ref
) => ref.watch(fluentProvider$).isDark;