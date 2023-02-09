import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider, ProviderRef;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/modules/fluent/providers/fluent_provider.dart';

class HomeController {

  const HomeController(this.ref);

  final ProviderRef ref;

  void colorChange(String color) {

    switch (color) {
      case 'blue':
        ref.read(fluentProvider.notifier).interpolator([
          ref.read(fluentProvider).darkMode ? const Color(0xFF0C4A6E) : const Color.fromARGB(255, 136, 202, 238),
          const Color(0xFF0369A1),
          ref.read(fluentProvider).darkMode ? TWColors.gray.shade100 : TWColors.gray.shade900
        ]);
        break;
      case 'violet':
        ref.read(fluentProvider.notifier).interpolator([
          ref.read(fluentProvider).darkMode ? const Color(0xFF581c87) : const Color(0xFFD8b4FE),
          const Color(0xFF7E22CE),
          ref.read(fluentProvider).darkMode ? TWColors.gray.shade100 : TWColors.gray.shade900
        ]);
        break;
      case 'red':
        ref.read(fluentProvider.notifier).interpolator([
          ref.read(fluentProvider).darkMode ? const Color(0xFF7F1D1D) : const Color(0xFFfCA5A5),
          const Color(0xFFB91C1C),
          ref.read(fluentProvider).darkMode ? TWColors.gray.shade100 : TWColors.gray.shade900
        ]);
        break;
      default:
        ref.read(fluentProvider.notifier).interpolator([
          ref.read(fluentProvider).darkMode ? const Color(0xFF064E3B) : const Color(0xFF6EE7B7),
          const Color(0xFF047857),
          ref.read(fluentProvider).darkMode ? TWColors.gray.shade100 : TWColors.gray.shade900
        ]);
        break;
    }
  }

  Color backSelector(String color) {
    switch (color) {
      case 'blue': return const Color(0xFF0284C7);
      case 'violet': return const Color(0xFF9333EA);
      case 'red': return const Color(0xFFF3425B);
      default: return const Color(0xFF059669);
    }
  }

  Color borderSelector(String color) {
    switch (color) {
      case 'blue': return const Color(0xAA7DD3fC);
      case 'violet': return const Color(0xAAD8B4FE);
      case 'red': return const Color(0xAAfCA5A5);
      default: return const Color(0xAA6EE7B7);
    }
  }
}

final homeController = Provider(HomeController.new);