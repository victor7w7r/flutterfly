import 'package:fluent_ui/fluent_ui.dart';

import 'package:nester/nester.dart' show Nester;
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/config/extensions/extensions.dart';
import 'package:flutterfly/features/fluent/data/providers/fluent_provider.dart';

final class Header extends StatelessWidget {

  const Header({super.key});

  @override
  Widget build(context) {

    final theme = context.watch(fluentProvider);

    return Nester.list([
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
          onChanged: context.read(fluentProvider.notifier)
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