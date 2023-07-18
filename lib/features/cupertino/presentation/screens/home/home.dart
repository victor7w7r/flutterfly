import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/extensions/extensions.dart';
import 'package:flutterfly/features/common/presentation/widgets/consumer.dart';
import 'package:flutterfly/features/common/providers/data_provider.dart';
import 'package:flutterfly/features/cupertino/presentation/screens/home/home_widgets.dart';
import 'package:flutterfly/features/cupertino/presentation/widgets/theme_toggle.dart';

final class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(final BuildContext context) => n.Stack([
    const ThemeToggle().niku
      ..top = 70
      ..right = 0,
    n.Column([
      const DynamicChip(isHome: false),
      const SizedBox(height: 10),
      'Happy Hacking!, Dart... Dart...'.n
        ..fontSize = (context.mHeight > 960 ) ? 25 : 20
        ..n.center,
      const SizedBox(height: 10),
      AppConsumer((final ref) {
        final data = ref.watch(dataProvider$);
        return n.Text(data.isEmpty
          ? 'Store state: Not yet.'
          : 'Store state: Yes, you write. $data'
        )
          ..fontSize = data.isEmpty
            ? ((context.mHeight > 960 ) ? 20 : 15)
            : 20
          ..n.center;
      }),
        const SizedBox(height: 20),
        'Made with love by '.n
          ..freezed
          ..fontSize = 15
          ..n.center,
        const SizedBox(height: 20),
        const DynamicChip(isHome: true)
    ])
      ..mainCenter,
  ]);
}