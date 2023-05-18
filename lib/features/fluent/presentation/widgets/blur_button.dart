import 'package:fluent_ui/fluent_ui.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

final class BlurButton extends StatelessWidget {

  final String caption;
  final double fontSize;
  final VoidCallback onClick;

  const BlurButton({
    super.key,
    required this.caption,
    required this.onClick,
    this.fontSize = 14
  });

  @override
  Widget build(context) => FilledButton(
    onPressed: onClick,
    style: ButtonStyle(
      elevation: ButtonState.all<double>(0),
      foregroundColor: ButtonState.all<Color>(
        TWColors.gray.shade900
      ),
      backgroundColor: ButtonState.all<Color>(
        const Color.fromRGBO(255, 255, 255, 0.4)
      ),
      shape: ButtonState.all<RoundedRectangleBorder> (
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(
            color:Color.fromRGBO(204, 204, 204, 0)
          )
        )
      )
    ),
    child: caption.n
      ..fontFamily = 'FuturaPTMedium'
      ..fontSize = fontSize
      ..n.padding = const EdgeInsets.fromLTRB(
        10, 3, 10, 3
      )   // n.Button
  );
}