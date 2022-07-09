import 'package:flutter/widgets.dart';

class AnimatedGradient extends StatefulWidget {

  const AnimatedGradient({Key? key}) : super(key: key);

  @override
  State<AnimatedGradient> createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {

  final _colorList = const [
    Color(0xFF453F38), Color(0xFFEE7752), Color(0xFFE8E813),
    Color(0xFF23D5AB),  Color(0xFF23A6D5), Color(0xFFA113E8),
    Color(0xFFE73C7E)
  ];

  int _index = 0;
  Color _bottomColor = const Color(0xFF453F38);
  Color _topColor = const Color(0xFFE73C7E);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () =>
      setState(() => _bottomColor =const Color(0xFFEE7752))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 3),
          onEnd: () => setState(() {
            _index = _index + 1;
            _bottomColor = _colorList[_index % _colorList.length];
            _topColor = _colorList[(_index + 1) % _colorList.length];
          }),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [_bottomColor, _topColor]
            )
          )
        )
      ]
    );
  }
}