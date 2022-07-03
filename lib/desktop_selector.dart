import 'dart:async' show Timer;

import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutterfly/utils/animated_gradient.dart';

class DesktopSelector extends StatefulWidget {
  const DesktopSelector({
    Key? key,
    required this.callback
  }) : super(key: key);

  final void Function(String) callback;

  @override
  State<DesktopSelector> createState() => _DesktopSelectorState();

}

class _DesktopSelectorState extends State<DesktopSelector> {

  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => setState(() => _visible = !_visible));
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      color: const Color.fromRGBO(255, 255, 255, 1),
      debugShowCheckedModeBanner: false,
      home: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: Stack(
          children: [
            const Center(
              child: SizedBox(
                width: 2400.0,
                height: 2400.0,
                child: AnimatedGradient()
              )
            ),
            Column(
              children: [
                const Text('Choose your flavour',style: TextStyle(fontSize: 50.0, fontFamily: 'AminaReska', color: Colors.white)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: OutlinedButton(child: const Text('Material'), onPressed: () => _changeApp('material'))),
                      Expanded(child: OutlinedButton(child: const Text('Fluent'), onPressed: () => _changeApp('web') )),
                      Expanded(child: OutlinedButton(child: const Text('Cupertino'), onPressed: () => _changeApp('cupertino') )),
                    ]
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }

  void _changeApp(String selector) {
    setState(() => _visible = !_visible);
    Timer(const Duration(seconds: 1), () {
      widget.callback(selector);
    });
  }
}