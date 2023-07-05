import 'package:flutter/material.dart';

import 'package:flutterfly/core/extensions/extensions.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/material/presentation/screens/home/home_widgets.dart';
import 'package:flutterfly/features/material/presentation/widgets/widgets.dart';

final class Home extends StatelessWidget {

  const Home({ super.key });

  @override
  Widget build(context) => Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(isMacOS ? 35 : 50),
      child: const NavBar('My Home')
    ),
    drawer: isMacOS ? null : const DrawerMenu(),
    endDrawer: isMacOS ? const DrawerMenu() : null,
    body: OrientationBuilder(builder: (_, or) =>
      Flex(
        direction: or == Orientation.portrait
          ? Axis.vertical
          : Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: TopContent(
              height: context.mHeight,
              pOrientation: or
            )
          ),
          Expanded(
            flex: or == Orientation.portrait ? 2 : 1,
            child: BottomContent(
              height: context.mHeight,
              pOrientation: or
            )
          )
        ]
      )
    )
  );
}