import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/core/mvvm/base_mvvm.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_controller.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_widgets.dart';
import 'package:flutterfly/features/common/ui/widgets/widgets.dart';

class DesktopSelectorPage extends StatelessWidget {
  const DesktopSelectorPage({super.key});

  @override
  Widget build(
    final BuildContext context,
  ) =>
      MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        home: Material(
          color: Colors.black,
          child: ListenViewModel<DesktopSelectorController>(
            disposeLazy: true,
            onInit: (final ctl) => ctl.init(),
            builder: (final ctl) => AnimatedOpacity(
              opacity: ctl.initAnim ? 1.0 : 0.0,
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
          ),
        ),
      );
}
