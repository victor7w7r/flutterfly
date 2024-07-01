import 'package:flutter/material.dart';

import 'package:flutterfly/core/utils/utils.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_page.dart';
import 'package:flutterfly/features/common/ui/services/desktop_service.dart';
import 'package:flutterfly/features/cupertino/ui/layout/cupertino_layout.dart';
import 'package:flutterfly/features/fluent/ui/layout/fluent_layout.dart';
import 'package:flutterfly/features/material/ui/layout/material_layout.dart';

final class App extends StatelessWidget {
  const App({super.key, this.child});

  final Widget? child;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      LUViewModel<Platform, DesktopService>(
        builder: (final pt, final ctl) {
          if (pt.isIos()) {
            return child ?? const CupertinoLayout();
          } else if (pt.isAndroid()) {
            return const MaterialLayout();
          } else if (pt.isDesktop() && ctl.state != 'none') {
            if (ctl.state == 'material') {
              return const MaterialLayout();
            } else if (ctl.state == 'cupertino') {
              return const CupertinoLayout();
            } else {
              return const FluentLayout();
            }
          } else {
            return const DesktopSelectorPage();
          }
        },
      );
}
