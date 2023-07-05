import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/extensions/extensions.dart';
import 'package:flutterfly/features/common/presentation/widgets/nest.dart';
import 'package:flutterfly/features/fluent/providers/fluent_provider.dart';

final class Header extends ConsumerWidget {

  const Header({super.key});

  @override
  Widget build(context, ref) {

    final theme = ref.watch(fluentProvider$);

    return Nest([
      (next) => Card(
        backgroundColor: theme.themeColor[1],
        borderRadius: BorderRadius.circular(20),
        child: next
      ), (next) => FractionallySizedBox(
        widthFactor: 0.98,
        child: next
      ), (_) => n.Row([
        n.Row([
          n.Image.asset('assets/flutter-logo.png')
            ..width = 50
            ..height = 30,
          'Flutter Template'.n
            ..color = theme.themeColor[2]
        ])
          ..pl = context.mWidth > 960 ? 200 : 50,
        ToggleSwitch(
          checked: theme.isDark,
          onChanged: ref.read(fluentProvider$.notifier)
            .toggle,
          content: 'Dark Mode'.n
            ..color = theme.themeColor[2]
        ).niku
          ..pr = context.mWidth > 960 ? 200 : 50
      ])
        ..mainAxisAlignment = MainAxisAlignment.spaceBetween
    ]);
  }
}