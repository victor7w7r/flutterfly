import 'package:fluent_ui/fluent_ui.dart';
import 'package:niku/namespace.dart' as n;

final class BlurButton extends StatelessWidget {
  const BlurButton({
    required this.caption,
    required this.onClick,
    super.key,
    this.fontSize = 14,
  });

  final String caption;
  final double fontSize;
  final VoidCallback onClick;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      FilledButton(
        onPressed: onClick,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            const Color.fromRGBO(255, 255, 255, 0.4),
          ),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
          elevation: WidgetStateProperty.all<double>(0),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(204, 204, 204, 0)),
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
          ),
        ),
        child: caption.n
          ..fontFamily = 'FuturaPTMedium'
          ..fontSize = fontSize
          ..n.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      );
}
