import 'package:flutter/material.dart';

import 'package:flutterfly/core/di/inject.dart';
import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/material/ui/widgets/widgets.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key, this.child, this.secondChild});

  final Widget? child;
  final Widget? secondChild;

  @override
  Widget build(final BuildContext context) =>
      child ??
      Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(inject.get<Platform>().isMacOS() ? 35 : 50),
          child: NavBar('My Home', child: secondChild),
        ),
        drawer: inject.get<Platform>().isMacOS() ? null : const DrawerMenu(),
        endDrawer: inject.get<Platform>().isMacOS() ? const DrawerMenu() : null,
        body: OrientationBuilder(
          builder: (final _, final or) => Flex(
            direction:
                or == Orientation.portrait ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(
                flex: context.isMinMd ? 3 : 1,
                child: TopContent(
                  height: context.mHeight,
                  pOrientation: or,
                  child: secondChild,
                ),
              ),
              Expanded(
                flex: or == Orientation.portrait ? 4 : 1,
                child: BottomContent(
                  height: context.mHeight,
                  pOrientation: or,
                  child: secondChild,
                ),
              ),
            ],
          ),
        ),
      );
}
