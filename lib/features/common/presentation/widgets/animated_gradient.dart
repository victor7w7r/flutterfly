import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AnimatedGradientController extends ChangeNotifier {
  AnimatedGradientController()
      : _bottomColor = const Color.fromRGBO(253, 186, 116, 1),
        _colors = [
          const Color.fromRGBO(82, 82, 91, 1),
          const Color.fromRGBO(249, 115, 22, 1),
          const Color.fromRGBO(250, 204, 21, 1),
          const Color.fromRGBO(74, 222, 128, 1),
          const Color.fromRGBO(59, 130, 246, 1),
          const Color.fromRGBO(162, 28, 175, 1),
          const Color.fromRGBO(244, 63, 94, 1),
        ],
        _index = 0,
        _topColor = const Color.fromRGBO(253, 186, 116, 1);

  Color _bottomColor;
  final List<Color> _colors;
  int _index;
  Color _topColor;

  void end() {
    _index++;
    bottomColor = _colors[_index % _colors.length];
    topColor = _colors[(_index + 1) % _colors.length];
  }

  void init() => Future.delayed(
        Duration.zero,
        () => bottomColor = const Color.fromRGBO(253, 186, 116, 1),
      );

  Color get bottomColor => _bottomColor;

  set bottomColor(final Color value) {
    _bottomColor = value;
    notifyListeners();
  }

  Color get topColor => _topColor;

  set topColor(final Color value) {
    _topColor = value;
    notifyListeners();
  }
}

typedef _Ctl = AnimatedGradientController;

final animatedGradientController =
    ChangeNotifierProvider<_Ctl>((final _) => _Ctl()..init());

final class AnimatedGradient extends ConsumerWidget {
  const AnimatedGradient({this.width = 2400, this.height = 2400, super.key});

  final double height;
  final double width;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ctl = ref.watch(animatedGradientController);

    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      onEnd: ctl.end,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [ctl.bottomColor, ctl.topColor],
        ),
      ),
    );
  }
}
