import 'dart:async' show Timer;

import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutterfly/utils/animated_gradient.dart';

class DesktopSelector extends StatefulWidget {
  const DesktopSelector({Key? key, required this.callback}) : super(key: key);

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
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Choose your flavour',
                style: TextStyle(
                  fontSize: 50.0, fontFamily: 'AminaReska', color: Colors.white
                )
              )
            ),
            Center(
              child: Wrap(
                spacing: 50,
                children: [
                  _menuBuilder(context, 'Material', 'material', 'material'),
                  _menuBuilder(context, 'Fluent', 'fluent', 'web'),
                  _menuBuilder(context, 'Cupertino', 'cupertino', 'cupertino')
                ]
              )
            )
          ]
        )
      )
    );
  }

  Column _menuBuilder(BuildContext context, String title, String image, String selector) {
    return Column(
      children: [
        Text(
          title, style: const TextStyle(
            fontSize: 30.0, fontFamily: 'AminaReska', color: Colors.white
          )
        ),
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(120),
              child: Image.asset('assets/$image.jpg', fit: BoxFit.cover)
            )
          ),
          onTap: () {
            setState(() => _visible = !_visible);
            Timer(const Duration(seconds: 1), () => widget.callback(selector));
          }
        )
      ]
    );
  }
}