import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/services/desktop.riverpod.dart';
import 'package:flutterfly/features/common/ui/screens/desktop_selector_widgets.dart';
import 'package:flutterfly/features/common/ui/widgets/widgets.dart';

class DesktopSelector extends ConsumerStatefulWidget {
  const DesktopSelector({super.key});

  @override
  ConsumerState<DesktopSelector> createState() => _DesktopSelectorState();
}

class _DesktopSelectorState extends ConsumerState<DesktopSelector> {
  bool _init = false;

  void _exit(final String selector) {
    _init = !_init;
    setState(() {});
    Future.delayed(
      const Duration(seconds: 1),
      () => ref.read(desktopProvider$.notifier).mutate = selector,
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _init = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        home: Material(
          color: Colors.black,
          child: AnimatedOpacity(
            opacity: _init ? 1.0 : 0.0,
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
                  onTap: () => _exit('material'),
                ),
                MenuBuilder(
                  title: 'Fluent',
                  image: 'fluent',
                  onTap: () => _exit('web'),
                ),
                MenuBuilder(
                  title: 'Cupertino',
                  image: 'cupertino',
                  onTap: () => _exit('cupertino'),
                ),
              ])
                ..spacing = 50
                ..n.center,
              if (isDesktop) const WindowTitleBar(isDark: true),
            ]),
          ),
        ),
      );
}
