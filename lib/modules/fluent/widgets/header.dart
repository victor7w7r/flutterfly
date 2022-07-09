import 'package:fluent_ui/fluent_ui.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show FluentProvider;

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<FluentProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Card(
      backgroundColor: themeProvider.cardColor,
      borderRadius: BorderRadius.circular(20),
      elevation: 0.0,
      child: FractionallySizedBox(
        widthFactor: 0.98,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: size.width > 960
                ? const EdgeInsets.fromLTRB(200, 0, 0, 0)
                : const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Row(
                children: [
                  Image.asset('assets/flutter-logo.png', width: 50.0, height: 30.0),
                  Text('Flutter Template', style: TextStyle(color: themeProvider.invertedColor))
                ]
              )
            ),
            Padding(
              padding: size.width > 960
                ? const EdgeInsets.fromLTRB(0, 0, 200, 0)
                : const EdgeInsets.fromLTRB(0, 0, 50, 0),
              child: ToggleSwitch(
                checked: themeProvider.darkMode,
                onChanged: (v) {
                  themeProvider.toggle(v);
                  setState(() => themeProvider.darkMode = v);
                },
                content: Text('Dark Mode', style: TextStyle(color: themeProvider.invertedColor))
              )
            )
          ]
        )
      )
    );
  }
}