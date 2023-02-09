import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Consumer;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/modules/common/providers/data_provider.dart';
import 'package:flutterfly/modules/cupertino/views/home/home_widgets.dart';
import 'package:flutterfly/modules/cupertino/widgets/theme_toggle.dart';
import 'package:flutterfly/utils/context_extensions.dart';

class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(context) => n.Stack([
    const ThemeToggle().niku
      ..top = 70
      ..right = 0,
    n.Column([
      const DynamicChip(isHome: false),
      const SizedBox(height: 10),
      "Happy Hacking!, Dart... Dart...".n
        ..fontSize = (context.mediaQuerySize.height > 960 ) ? 25 : 20
        ..n.center,
      const SizedBox(height: 10),
      Consumer(builder: (_, ref, __) {
        final data = ref.watch(dataProvider);
        return n.Text(data.isEmpty
          ? "Store state: Not yet."
          : "Store state: Yes, you write. $data"
        )
          ..fontSize = data.isEmpty ? ((context.mediaQuerySize.height > 960 ) ? 20 : 15) : 20
          ..n.center;
      }),
        const SizedBox(height: 20),
        "Made with love by ".n
          ..freezed
          ..fontSize = 15
          ..n.center,
        const SizedBox(height: 20),
        const DynamicChip(isHome: true)
    ])
      ..mainAxisAlignment = MainAxisAlignment.center,
  ]);
}