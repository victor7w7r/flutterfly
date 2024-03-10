import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';

final class DynamicChip extends StatelessWidget {
  const DynamicChip({required this.isHome, super.key});

  final bool isHome;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<CupertinoService>(
        builder: (final ctl) => Container(
          width: isHome ? 300 : 270,
          height: isHome ? 60 : 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: ctl.isDark
                ? Border.all(
                    width: 2,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  )
                : Border.all(
                    width: 2,
                    color: const Color.fromARGB(255, 26, 31, 43),
                  ),
          ),
          child: n.Row(
            isHome
                ? [
                    const SizedBox(width: 38),
                    n.Image.asset(
                      ctl.isDark ? 'assets/brandwhite.png' : 'assets/brand.png',
                    )
                      ..width = 220.0
                      ..height = 70.0,
                  ]
                : [
                    n.Image.asset('assets/flutter-logo.png')
                      ..width = 77.0
                      ..height = 35.0,
                    'Flutter Template'.n
                      ..freezed
                      ..fontSize = 20,
                  ],
          ),
        ),
      );
}
