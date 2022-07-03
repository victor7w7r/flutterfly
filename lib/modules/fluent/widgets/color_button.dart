import 'package:fluent_ui/fluent_ui.dart';

class ColorButton extends StatelessWidget {

  const ColorButton({
    Key? key,
    required this.color,
    required this.onClick
  }) : super(key: key);

  final String color;
  final VoidCallback onClick;


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
      onPressed:() => onClick(),
      child: const Padding (
        padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
      )
    );
  }

  Color _backSelector() {
    switch (color) {
      case 'blue':
        return const Color(0xFF0284C7);
      case 'violet':
        return const Color(0xFF9333EA);
      case 'red':
        return const Color(0xFFF3425B);
      default:
        return const Color(0xFF059669);
    }
  }

  Color _borderSelector() {
    switch (color) {
      case 'blue':
        return const Color(0xAA7DD3fC);
      case 'violet':
        return const Color(0xAAD8B4FE);
      case 'red':
        return const Color(0xAAfCA5A5);
      default:
        return const Color(0xAA6EE7B7);
    }
  }

}