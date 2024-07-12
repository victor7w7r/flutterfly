import 'package:flutter/cupertino.dart';

import 'package:get_it/get_it.dart' show GetIt;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/widgets/title_bar.dart';

final class CupTitle extends StatelessWidget {
  const CupTitle(this.dark, {super.key, this.child});

  final Widget? child;
  final bool dark;

  @override
  Widget build(final BuildContext context) {
    if (GetIt.I<Platform>().isMacOS) {
      return WindowTitleBar(isDark: dark, child: child);
    } else if (!GetIt.I<Platform>().isDesktop) {
      return 'CupertinoApp'.n..freezed;
    } else {
      return n.Stack([
        'CupertinoApp'.n
          ..freezed
          ..mx = 10
          ..my = 5,
        WindowTitleBar(isDark: dark, child: child),
      ]);
    }
  }
}
