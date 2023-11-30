import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/presentation/screens/desktop_selector.riverpod.dart';
import 'package:flutterfly/features/common/presentation/screens/desktop_selector_widgets.dart';
import 'package:flutterfly/features/common/presentation/widgets/widgets.dart';

final class DesktopSelector extends ConsumerWidget {
  const DesktopSelector({super.key});

  @override
  Widget build(
    final BuildContext context,
    final WidgetRef ref,
  ) {
    final isOpacity = ref.watch(desktopSelectorController$);

    final ctl = ref.read(desktopSelectorController$.notifier);

    return FluentApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: AnimatedOpacity(
        opacity: isOpacity ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: n.Stack([
          const AnimatedGradient(),
          'Choose your flavour'.n
            ..fontSize = 50
            ..fontFamily = 'AminaReska'
            ..color = Colors.white
            ..n.align = Alignment.topCenter,
          n.Wrap([
            MenuBuilder(
              title: 'Material',
              image: 'material',
              onTap: () => ctl.exit('material'),
            ),
            MenuBuilder(
              title: 'Fluent',
              image: 'fluent',
              onTap: () => ctl.exit('web'),
            ),
            MenuBuilder(
              title: 'Cupertino',
              image: 'cupertino',
              onTap: () => ctl.exit('cupertino'),
            ),
          ])
            ..spacing = 50
            ..n.center,
          if (isDesktop) const WindowTitleBar(isDark: true),
        ]),
      ),
    );
  }
}
