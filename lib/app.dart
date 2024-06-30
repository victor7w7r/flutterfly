import 'package:flutter/widgets.dart';

import 'package:flutterfly/core/utils/utils.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_page.dart';
import 'package:flutterfly/features/common/ui/services/desktop_service.dart';
import 'package:flutterfly/features/cupertino/ui/cupertino.dart';
import 'package:flutterfly/features/fluent/ui/fluent.dart';
import 'package:flutterfly/features/material/ui/material.dart';

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(
    final BuildContext context,
  ) =>
      LUViewModel<Platform, DesktopService>(
        builder: (final pt, final ctl) {
          if (pt.isIos()) {
            return const CupertinoModule();
          } else if (pt.isAndroid()) {
            return const MaterialModule();
          } else if (pt.isDesktop() && ctl.state != 'none') {
            if (ctl.state == 'material') {
              return const MaterialModule();
            } else if (ctl.state == 'cupertino') {
              return const CupertinoModule();
            } else {
              return const FluentModule();
            }
          } else {
            return const DesktopSelectorPage();
          }
        },
      );
}
