import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;
import 'package:tailwind_colors/tailwind_colors.dart' show TWTwoColors;

import 'package:flutterfly/core/utils/index.dart';
import 'package:flutterfly/features/common/presentation/views/desktop_selector_controller.dart';
import 'package:flutterfly/features/common/presentation/views/desktop_selector_widgets.dart';
import 'package:flutterfly/features/common/presentation/widgets/widgets.dart';

class DesktopSelector extends HookWidget {

  const DesktopSelector({super.key});

  @override
  Widget build(context) {

    final ctl = context.watch(
      desktopSelectorProvider
    );

    useMount(() => Future.delayed(
      Duration.zero,
      () => ctl.visible = true
    ));

    return FluentApp(
      color: TWTwoColors.gray.shade100,
      debugShowCheckedModeBanner: false,
      home: AnimatedOpacity(
        opacity: ctl.visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: n.Stack([
          const AnimatedGradient(),
          'Choose your flavour'.n
            ..fontSize = 50
            ..fontFamily = 'AminaReska'
            ..color = TWTwoColors.gray.shade100
            ..n.align = Alignment.topCenter,
          n.Wrap([
            MenuBuilder(
              title: 'Material',
              image: 'material',
              onTap: () => ctl.exit('material')
            ),
            MenuBuilder(
              title: 'Fluent',
              image: 'fluent',
              onTap: () => ctl.exit('web')
            ),
            MenuBuilder(
              title: 'Cupertino',
              image: 'cupertino',
              onTap: () => ctl.exit('cupertino')
            )
          ])
            ..spacing = 50
            ..n.center,
          if(isDesktop) const WindowTitleBar(isDark: true)
        ])
      )
    );
  }
}