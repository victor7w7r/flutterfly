import 'package:flutter/material.dart';

import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/material/ui/widgets/widgets.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isMacOS ? 35 : 50),
          child: const NavBar('My Home'),
        ),
        drawer: isMacOS ? null : const DrawerMenu(),
        endDrawer: isMacOS ? const DrawerMenu() : null,
        body: OrientationBuilder(
          builder: (final _, final or) => Flex(
            direction:
                or == Orientation.portrait ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(
                child: TopContent(
                  height: context.mHeight,
                  pOrientation: or,
                ),
              ),
              Expanded(
                flex: or == Orientation.portrait ? 2 : 1,
                child: BottomContent(
                  height: context.mHeight,
                  pOrientation: or,
                ),
              ),
            ],
          ),
        ),
      );
}
