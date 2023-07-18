import 'dart:async' show unawaited;

import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/presentation/widgets/widgets.dart';
import 'package:flutterfly/features/common/providers/providers.dart';
import 'package:flutterfly/features/cupertino/presentation/screens/store/store_controller.dart';
import 'package:flutterfly/features/fluent/presentation/screens/store/store_widgets.dart';
import 'package:flutterfly/features/fluent/presentation/widgets/widgets.dart';
import 'package:flutterfly/features/fluent/providers/fluent_provider.dart';

final class Store extends ConsumerWidget {

  const Store({super.key});

  @override
  Widget build(
    final BuildContext context,
    final WidgetRef ref
  ) {

    final theme = ref.watch(fluentProvider$);

    final ctl = ref.read(storeController$);

    return ColoredBox(
      color: theme.themeColor[0],
      child: n.Column([
        if(!isWeb) WindowTitleBar(isDark: theme.isDark),
        const SizedBox(height: 10),
        const Header(),
        const SizedBox(height: 50),
        n.Column([
          n.Row([Card(
            backgroundColor: theme.themeColor[1],
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
            child: n.Column([
              const SizedBox(height: 45),
              'Write anything in this form and send!'.n
                ..color = theme.themeColor[2]
                ..fontSize = 20,
              const SizedBox(height: 30),
              StoreText(ctl: ctl.txtCtl, theme: theme),
              const SizedBox(height: 30),
              BlurButton(
                caption: 'Send',
                onClick: () => ctl.request(context)
              ),
              const SizedBox(height: 45),
              AppConsumer((final ref) {
                final data = ref.watch(dataProvider$);
                return n.Text(data.isEmpty
                  ? 'Store state: Not yet.'
                  : 'Store state: Yes, you write. $data'
                )
                  ..fontSize = 20
                  ..color = theme.themeColor[2]
                  ..n.center;
              }),
              const SizedBox(height: 45)
            ])
          )])
            ..mainAxisAlignment = MainAxisAlignment.spaceEvenly,
          const SizedBox(height: 60),
          BlurButton(
            caption: 'Go to Home',
            onClick: () => unawaited(Navigator.of(context).pushNamed('/'))
          ),
          const SizedBox(height: 40)
        ])
      ])
    );
  }
}