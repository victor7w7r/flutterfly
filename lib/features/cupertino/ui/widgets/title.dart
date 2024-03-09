import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/widgets/title_bar.dart';

final class CupTitle extends StatelessWidget {
  const CupTitle(this.dark, {super.key});

  final bool dark;

  @override
  Widget build(final BuildContext context) {
    if (isMacOS) {
      return WindowTitleBar(isDark: dark);
    } else if (!isDesktop) {
      return 'CupertinoApp'.n..freezed;
    } else {
      return n.Stack([
        'CupertinoApp'.n
          ..freezed
          ..mx = 10
          ..my = 5,
        WindowTitleBar(isDark: dark),
      ]);
    }
  }
}
