import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

final class AnimatedGradient extends StatefulWidget {
  const AnimatedGradient({super.key});

  @override
  State<AnimatedGradient> createState() => _AnimatedGradientState();
}

final class _AnimatedGradientState extends State<AnimatedGradient> {
  Color _first = const Color.fromRGBO(253, 186, 116, 1);
  Color _last = const Color.fromRGBO(63, 63, 70, 1);

  final _colors = <Color>[
    const Color.fromRGBO(82, 82, 91, 1),
    const Color.fromRGBO(249, 115, 22, 1),
    const Color.fromRGBO(250, 204, 21, 1),
    const Color.fromRGBO(74, 222, 128, 1),
    const Color.fromRGBO(59, 130, 246, 1),
    const Color.fromRGBO(162, 28, 175, 1),
    const Color.fromRGBO(244, 63, 94, 1),
  ];
  int _index = 0;

  void end() {
    _index++;
    _first = _colors[(_index + 1) % _colors.length];
    _last = _colors[_index % _colors.length];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    unawaited(
      Future.delayed(Duration.zero, () {
        _last = const Color.fromRGBO(253, 186, 116, 1);
        setState(() {});
      }),
    );
  }

  @override
  Widget build(
    final BuildContext context,
  ) =>
      AnimatedContainer(
        duration: const Duration(seconds: 3),
        onEnd: end,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [_last, _first],
          ),
        ),
      );
}
