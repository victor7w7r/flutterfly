// coverage:ignore-file

import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:niku/namespace.dart' as n;

final class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({required this.isDark, this.child, super.key});

  final Widget? child;
  final bool isDark;

  @override
  Widget build(final BuildContext context) {
    final buttonColors = WindowButtonColors(
      normal: Colors.transparent,
      mouseOver: !isDark
          ? Colors.black.withOpacity(0.04)
          : Colors.white.withOpacity(0.04),
      mouseDown: !isDark
          ? Colors.black.withOpacity(0.08)
          : Colors.white.withOpacity(0.08),
      iconNormal: !isDark ? Colors.black : Colors.white,
      iconMouseOver: !isDark ? Colors.black : Colors.white,
      iconMouseDown: !isDark ? Colors.black : Colors.white,
    );

    return child ??
        WindowTitleBarBox(
          child: n.Row([
            Expanded(child: MoveWindow()),
            n.Row([
              MinimizeWindowButton(colors: buttonColors),
              MaximizeWindowButton(colors: buttonColors),
              CloseWindowButton(
                colors: buttonColors,
                onPressed: appWindow.close,
              ),
            ]),
          ]),
        );
  }
}
