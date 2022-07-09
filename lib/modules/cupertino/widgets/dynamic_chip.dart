import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'package:flutterfly/providers/providers.dart' show CupertinoProvider;

class DynamicChip extends StatelessWidget {

  const DynamicChip({Key? key, required this.selector}) : super(key: key);

  final String selector;

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<CupertinoProvider>(context, listen: true);

    return Container(
      width: selector == 'home' ? 300 : 270,
      height: selector == 'home' ? 60 : 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: themeProvider.darkMode
          ? Border.all(width: 2, color: const Color.fromRGBO(255, 255, 255, 1))
          : Border.all(width: 2, color: const Color.fromRGBO(0, 0, 0, 1))
      ),
      child: Row(children: _imageSelector(selector, context))
    );
  }

  List<Widget> _imageSelector(String selector, BuildContext context) {

    final themeProvider = Provider.of<CupertinoProvider>(context, listen: true);

    if(selector == 'home') {
      return [
        const SizedBox(width: 38),
        Image.asset(
          themeProvider.darkMode
          ? 'assets/brandwhite.png'
          : 'assets/brand.png',
          width: 220.0, height: 70.0
        )
      ];
    } else {
      return [
        Image.asset('assets/flutter-logo.png', width: 77.0, height: 35.0),
        const Text('Flutter Template', style: TextStyle(fontSize: 20))
      ];
    }
  }
}