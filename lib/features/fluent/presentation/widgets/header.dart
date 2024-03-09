import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/features/common/ui/widgets/nest.dart';
import 'package:flutterfly/features/fluent/providers/fluent.riverpod.dart';

final class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final theme = ref.watch(fluentProvider$);

    return Nest([
      (final next) => Card(
            backgroundColor: theme.themeColor[1],
            borderRadius: BorderRadius.circular(20),
            child: next,
          ),
      (final next) => FractionallySizedBox(widthFactor: 0.98, child: next),
      (final _) => n.Row([
            n.Row([
              n.Image.asset('assets/flutter-logo.png')
                ..width = 50
                ..height = 30,
              'Flutter Template'.n..color = theme.themeColor[2],
            ])
              ..pl = context.mWidth > 960 ? 200 : 50,
            ToggleSwitch(
              checked: theme.isDark,
              onChanged: ref.read(fluentProvider$.notifier).toggle,
              content: 'Dark Mode'.n..color = theme.themeColor[2],
            ).niku
              ..pr = context.mWidth > 960 ? 200 : 50,
          ])
            ..mainAxisAlignment = MainAxisAlignment.spaceBetween,
    ]);
  }
}
