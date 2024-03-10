import 'package:flutter/cupertino.dart';
import 'package:flutterfly/core/mvvm/base_mvvm.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/features/cupertino/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/theme_toggle.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => n.Stack([
        const ThemeToggle().niku
          ..top = 70
          ..right = 0,
        n.Column([
          const DynamicChip(isHome: false),
          const SizedBox(height: 10),
          'Happy Hacking!, Dart... Dart...'.n
            ..fontSize = (context.mHeight > 960) ? 25 : 20
            ..n.center,
          const SizedBox(height: 10),
          ListenViewModel<DataService>(
            builder: (final ctl) => n.Text(
              ctl.state.isEmpty
                  ? 'Store state: Not yet.'
                  : 'Store state: Yes, you write. ${ctl.state}',
            )
              ..fontSize =
                  ctl.state.isEmpty ? ((context.mHeight > 960) ? 20 : 15) : 20
              ..n.center,
          ),
          const SizedBox(height: 20),
          'Made with love by '.n
            ..freezed
            ..fontSize = 15
            ..n.center,
          const SizedBox(height: 20),
          const DynamicChip(isHome: true),
        ])
          ..mainCenter,
      ]);
}
