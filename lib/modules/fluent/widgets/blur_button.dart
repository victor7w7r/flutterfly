import 'package:fluent_ui/fluent_ui.dart';

class BlurButton extends StatelessWidget {

  const BlurButton({
    Key? key,
    required this.caption,
    required this.onClick
  }) : super(key: key);

  final String caption;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        elevation: ButtonState.all<double>(0),
        foregroundColor: ButtonState.all<Color>(Colors.black),
        backgroundColor: ButtonState.all<Color>(const Color.fromARGB(171, 204, 204, 204)),
        shape: ButtonState.all<RoundedRectangleBorder> (
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color:Color.fromRGBO(204, 204, 204, 0))
          )
        )
      ),
      onPressed:() => onClick(),
      child: Padding (
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
        child: Text(
          caption,
          style: const TextStyle(fontFamily: 'FuturaPTMedium', fontSize: 20)
        )
      )
    );
  }
}