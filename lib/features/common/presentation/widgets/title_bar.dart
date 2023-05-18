import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:niku/namespace.dart' as n;

class WindowTitleBar extends StatelessWidget {

  final bool isDark;

  const WindowTitleBar({
    super.key,
    required this.isDark
  });

  @override
  Widget build(BuildContext context) {

    final buttonColors = WindowButtonColors(
      iconNormal: !isDark
        ? Colors.black
        : Colors.white,
      iconMouseDown: !isDark
        ? Colors.black
        : Colors.white,
      iconMouseOver: !isDark
        ? Colors.black
        : Colors.white,
      normal: Colors.transparent,
      mouseOver: !isDark
        ? Colors.black.withOpacity(0.04)
        : Colors.white.withOpacity(0.04),
      mouseDown: !isDark
        ? Colors.black.withOpacity(0.08)
        : Colors.white.withOpacity(0.08)
    );

    return WindowTitleBarBox(
      child: n.Row([
        Expanded(child: MoveWindow()),
        n.Row([
          MinimizeWindowButton(colors: buttonColors),
          MaximizeWindowButton(colors: buttonColors),
          CloseWindowButton(
            onPressed: appWindow.close,
            colors: buttonColors
          )
        ])
      ])
    );
  }
}