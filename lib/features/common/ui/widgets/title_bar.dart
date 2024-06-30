// coverage:ignore-file

import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:niku/namespace.dart' as n;

final class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({required this.isDark, this.mockChild, super.key});

  final Widget? mockChild;
  final bool isDark;

  @override
  Widget build(final BuildContext context) {
    final buttonColors = WindowButtonColors(
      iconNormal: !isDark ? Colors.black : Colors.white,
      iconMouseDown: !isDark ? Colors.black : Colors.white,
      iconMouseOver: !isDark ? Colors.black : Colors.white,
      normal: Colors.transparent,
      mouseOver: !isDark
          ? Colors.black.withOpacity(0.04)
          : Colors.white.withOpacity(0.04),
      mouseDown: !isDark
          ? Colors.black.withOpacity(0.08)
          : Colors.white.withOpacity(0.08),
    );

    return mockChild ??
        WindowTitleBarBox(
          child: n.Row([
            Expanded(child: MoveWindow()),
            n.Row([
              MinimizeWindowButton(colors: buttonColors),
              MaximizeWindowButton(colors: buttonColors),
              CloseWindowButton(
                onPressed: appWindow.close,
                colors: buttonColors,
              ),
            ]),
          ]),
        );
  }
}
