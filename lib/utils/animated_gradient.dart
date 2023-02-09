import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tailwind_colors/tailwind_colors.dart' show TWTwoColors;

import 'package:flutterfly/utils/hooks.dart';

class AnimatedGradient extends HookWidget {

  const AnimatedGradient({super.key});

  @override
  Widget build(context) {

    final index = useState<int>(0);
    final bottomColor = useState<Color>(TWTwoColors.gray.shade700);
    final topColor = useState<Color>(TWTwoColors.rose.shade500);

    final colorList = useRef<List<Color>>([
      TWTwoColors.gray.shade600,
      TWTwoColors.orange.shade500,
      TWTwoColors.yellow.shade400,
      TWTwoColors.green.shade400,
      TWTwoColors.blue.shade500,
      TWTwoColors.fuchsia.shade700,
      TWTwoColors.rose.shade500
    ]);

    useMount(() =>
      Future.delayed(Duration.zero, () => bottomColor.value = TWTwoColors.orange.shade300)
    );

    return n.Stack([
      AnimatedContainer(
        duration: const Duration(seconds: 3),
        onEnd: () {
          index.value++;
          bottomColor.value = colorList.value[ index.value % colorList.value.length];
          topColor.value = colorList.value[( index.value + 1) % colorList.value.length];
        },
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [bottomColor.value, topColor.value]
          )
        )
      )
    ])
      ..width = 2400
      ..height = 2400
      ..n.center;
  }
}