import 'package:fluent_ui/fluent_ui.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  bool _checked = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: const Color(0xFF20242D),
      borderRadius: BorderRadius.circular(20),
      elevation: 0.0,
      child: FractionallySizedBox(
        widthFactor: 0.98,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
              child: Row(
                children: [
                  Image.asset('assets/flutter-logo.png', width: 50.0, height: 30.0),
                  const Text('Flutter Template', style: TextStyle(color: Colors.white))
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 200, 0),
              child: ToggleSwitch(
                checked: _checked,
                onChanged: (v) => setState(() => _checked = v),
                content: const Text('Dark Mode', style: TextStyle(color: Colors.white))
              )
            )
          ]
        )
      )
    );
  }
}