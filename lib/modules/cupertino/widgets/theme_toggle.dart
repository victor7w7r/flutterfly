import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show CupertinoProvider;

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({Key? key}) : super(key: key);

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<CupertinoProvider>(context, listen: false);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: -5,
      children: [
        const Text('Dark Mode', style: TextStyle(fontSize: 13)),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch (
            value: themeProvider.darkMode,
            onChanged: (value){
              themeProvider.toggle();
              themeProvider.darkMode = value;
              setState(() {});
            },
            thumbColor: CupertinoColors.white,
            activeColor: CupertinoColors.activeBlue
          )
        )
      ]
    );
  }
}