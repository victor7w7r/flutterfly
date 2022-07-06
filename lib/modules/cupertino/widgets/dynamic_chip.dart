import 'package:flutter/widgets.dart';

class DynamicChip extends StatelessWidget {

  const DynamicChip({Key? key, required this.selector}) : super(key: key);

  final String selector;

  @override
  Widget build(BuildContext context) {


    final themeProvider = Provider.of<ThemeCupertinoProvider>(context, listen: false);

    return Container(
      width: selector == 'home' ? 300 : 270,
      height: selector == 'home' ? 60 : 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: value
          ? Border.all(width: 2, color: const Color.fromRGBO(255, 255, 255, 1))
          : Border.all(width: 2, color: const Color.fromRGBO(0, 0, 0, 1))
      ),
      child: Row(children: _imageSelector(selector))
    );
  }

  List<Widget> _imageSelector(String selector) {
    if(selector == 'home') {
      return [
        const SizedBox(width: 38),
        Image.asset(value ? 'assets/brandwhite.png' : 'assets/brand.png', width: 220.0, height: 70.0)
      ];
    } else {
      return [
        Image.asset('assets/flutter-logo.png', width: 77.0, height: 35.0),
        const Text('Flutter Template', style: TextStyle(fontSize: 20))
      ];
    }
  }
}