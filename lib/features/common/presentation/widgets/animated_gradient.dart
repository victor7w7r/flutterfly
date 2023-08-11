import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tailwind_colors/tailwind_colors.dart' show TWTwoColors;

final class AnimatedGradientController
  extends ChangeNotifier {

  AnimatedGradientController():
    _bottomColor = TWTwoColors.gray.shade700,
    _colors = [
      TWTwoColors.gray.shade600,
      TWTwoColors.orange.shade500,
      TWTwoColors.yellow.shade400,
      TWTwoColors.green.shade400,
      TWTwoColors.blue.shade500,
      TWTwoColors.fuchsia.shade700,
      TWTwoColors.rose.shade500
    ],
    _index = 0,
    _topColor = TWTwoColors.orange.shade300;

  Color _bottomColor;
  final List<Color> _colors;
  int _index;
  Color _topColor;

  void end() {
    _index++;
    bottomColor = _colors[
      _index % _colors.length
    ];
    topColor = _colors[
      (_index + 1) % _colors.length
    ];
  }

  void init() => Future.delayed(Duration.zero, () =>
    bottomColor = TWTwoColors.orange.shade300
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
  ChangeNotifierProvider<_Ctl>((final _) =>
    _Ctl()..init()
  );

final class AnimatedGradient extends ConsumerWidget {

  const AnimatedGradient({
    this.width = 2400,
    this.height = 2400,
    super.key
  });

  final double height;
  final double width;

  @override
  Widget build(
    final BuildContext context,
    final WidgetRef ref
  ) {

    final ctl = ref.watch(
      animatedGradientController
    );

    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      onEnd: ctl.end,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [ctl.bottomColor, ctl.topColor]
        )
      )
    );
  }
}
