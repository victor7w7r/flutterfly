import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/di/inject.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/widgets/title_bar.dart';

final class CupTitle extends StatelessWidget {
  const CupTitle(this.dark, {super.key, @visibleForTesting this.mockChild});

  final Widget? mockChild;
  final bool dark;

  @override
  Widget build(final BuildContext context) {
    if (inject.get<Platform>().isMacOS()) {
      return WindowTitleBar(isDark: dark, mockChild: mockChild);
    } else if (!inject.get<Platform>().isDesktop()) {
      return 'CupertinoApp'.n..freezed;
    } else {
      return n.Stack([
        'CupertinoApp'.n
          ..freezed
          ..mx = 10
          ..my = 5,
        WindowTitleBar(isDark: dark, mockChild: mockChild),
      ]);
    }
  }
}
