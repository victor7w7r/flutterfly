import 'package:flutter/material.dart';

import 'package:flutterfly/modules/material/widgets/appbar.dart';
import 'package:flutterfly/modules/material/widgets/drawer_menu.dart';
import 'package:flutterfly/modules/material/views/home/home_widgets.dart';
import 'package:flutterfly/utils/index.dart';

class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(context) => Scaffold(
    appBar: appBar("My Home"),
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
            child: TopContent(pSize: context.mediaQuerySize, pOrientation: or)
          ),
          Expanded(
            flex: or == Orientation.portrait ? 2 : 1,
            child: BottomContent(pSize: context.mediaQuerySize, pOrientation: or)
          )
        ]
      )
    )
  );
}