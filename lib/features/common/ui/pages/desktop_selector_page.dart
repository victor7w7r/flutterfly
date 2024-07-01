import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/di/inject.dart';
import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_controller.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_widgets.dart';
import 'package:flutterfly/features/common/ui/widgets/widgets.dart';

final class SelectionWrap extends StatelessWidget {
  const SelectionWrap(this._ctl, {super.key});

  final DesktopSelectorController _ctl;

  @override
  Widget build(final BuildContext context) => n.Wrap([
        MenuBuilder(
          title: 'Material',
          image: 'material',
          onTap: () => _ctl.exit('material'),
        ),
        MenuBuilder(
          title: 'Fluent',
          image: 'fluent',
          onTap: () => _ctl.exit('web'),
        ),
        MenuBuilder(
          title: 'Cupertino',
          image: 'cupertino',
          onTap: () => _ctl.exit('cupertino'),
        ),
      ])
        ..spacing = 50
        ..n.center;
}

final class DesktopSelectorPage extends StatelessWidget {
  const DesktopSelectorPage({super.key, this.child});

  final Widget? child;

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
              opacity: ctl.isInitAnim ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: n.Stack([
                const AnimatedGradient(),
                'Choose your flavour'.n
                  ..fontSize = context.mWidth < 530 ? 40 : 60
                  ..fontFamily = 'AminaReska'
                  ..color = Colors.white
                  ..n.align = Alignment.topCenter,
                context.mWidth < 530
                    ? (SingleChildScrollView(child: SelectionWrap(ctl)).niku
                      ..pt = 100)
                    : SelectionWrap(ctl),
                if (inject.get<Platform>().isDesktop())
                  WindowTitleBar(isDark: true, child: child),
              ]),
            ),
          ),
        ),
      );
}
