import 'package:fluent_ui/fluent_ui.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show FluentProvider;

class ColorButton extends StatelessWidget {

  const ColorButton({Key? key, required this.color}) : super(key: key);

  final String color;

  @override
  Widget build(BuildContext context) {
    return Button(
      style: ButtonStyle(
        elevation: ButtonState.all<double>(0),
        backgroundColor: ButtonState.all<Color>(_backSelector()),
        shape: ButtonState.all<CircleBorder> (
          CircleBorder(
            side: BorderSide(
              width: 4,
              color:_borderSelector(),
              style: BorderStyle.solid
            )
          )
        )
      ),
      onPressed: () => colorChange(context),
      child: const Padding (padding: EdgeInsets.fromLTRB(25, 25, 25, 25))
    );
  }

  void colorChange(BuildContext context) {
    final themeProvider = Provider.of<FluentProvider>(context, listen: false);
    switch (color) {
      case 'blue':
        themeProvider.interpolator(
          themeProvider.darkMode
            ? const Color(0xFF0C4A6E)
            : const Color(0xAA7DD3fC), 'background'
        );
        themeProvider.interpolator(const Color(0xFF0369A1), 'card');
        break;
      case 'violet':
        themeProvider.interpolator(
          themeProvider.darkMode
            ? const Color(0xFF581c87)
            : const Color(0xFFD8b4FE), 'background'
        );
        themeProvider.interpolator(const Color(0xFF7E22CE), 'card');
        break;
      case 'red':
        themeProvider.interpolator(
          themeProvider.darkMode
            ? const Color(0xFF7F1D1D)
            : const Color(0xFFfCA5A5), 'background'
        );
        themeProvider.interpolator(const Color(0xFFB91C1C), 'card');
        break;
      default:
        themeProvider.interpolator(
          themeProvider.darkMode
            ? const Color(0xFF064E3B)
            : const Color(0xFF6EE7B7), 'background'
        );
        themeProvider.interpolator(const Color(0xFF047857), 'card');
        break;
    }
  }

  Color _backSelector() {
    switch (color) {
      case 'blue': return const Color(0xFF0284C7);
      case 'violet': return const Color(0xFF9333EA);
      case 'red': return const Color(0xFFF3425B);
      default: return const Color(0xFF059669);
    }
  }

  Color _borderSelector() {
    switch (color) {
      case 'blue': return const Color(0xAA7DD3fC);
      case 'violet': return const Color(0xAAD8B4FE);
      case 'red': return const Color(0xAAfCA5A5);
      default: return const Color(0xAA6EE7B7);
    }
  }
}