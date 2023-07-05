import 'package:fluent_ui/fluent_ui.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/features/fluent/providers/fluent_provider.dart';

part 'home_controller.g.dart';

final class HomeController {

  final HomeControllerRef _ref;

  const HomeController(this._ref);

  Color _background() =>
    _ref.read(fluentProvider$).isDark
      ? TWColors.gray.shade100
      : TWColors.gray.shade900;

  void colorChange(final String color) {
    switch (color) {
      case 'blue':
        _ref.read(fluentProvider$.notifier).interpolator([
          _ref.read(fluentProvider$).isDark
            ? const Color(0xFF0C4A6E)
            : const Color.fromARGB(255, 136, 202, 238),
          const Color(0xFF0369A1),
          _background()
        ]);
        break;
      case 'violet':
        _ref.read(fluentProvider$.notifier).interpolator([
          _ref.read(fluentProvider$).isDark
            ? const Color(0xFF581c87)
            : const Color(0xFFD8b4FE),
          const Color(0xFF7E22CE),
          _background()
        ]);
        break;
      case 'red':
        _ref.read(fluentProvider$.notifier).interpolator([
          _ref.read(fluentProvider$).isDark
            ? const Color(0xFF7F1D1D)
            : const Color(0xFFfCA5A5),
          const Color(0xFFB91C1C),
          _background()
        ]);
        break;
      default:
        _ref.read(fluentProvider$.notifier).interpolator([
          _ref.read(fluentProvider$).isDark
            ? const Color(0xFF064E3B)
            : const Color(0xFF6EE7B7),
          const Color(0xFF047857),
          _background()
        ]);
        break;
    }
  }

  Color backSelector(final String color) =>
    switch (color) {
      'blue' => const Color(0xFF0284C7),
      'violet' => const Color(0xFF9333EA),
      'red' => const Color(0xFFF3425B),
      _ => const Color(0xFF059669)
    };


  Color borderSelector(final String color) =>
    switch (color) {
      'blue' => const Color(0xAA7DD3fC),
      'violet' => const Color(0xAAD8B4FE),
      'red' => const Color(0xAAfCA5A5),
      _ => const Color(0xAA6EE7B7)
    };

}

@riverpod
HomeController homeController(
  final HomeControllerRef ref
) => HomeController(ref);