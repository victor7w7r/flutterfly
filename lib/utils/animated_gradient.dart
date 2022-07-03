import 'package:flutter/widgets.dart';

class AnimatedGradient extends StatefulWidget {

  const AnimatedGradient({Key? key}) : super(key: key);

  @override
  State<AnimatedGradient> createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {

  List<Color> colorList = const [
    Color(0xFF453F38), Color(0xFFEE7752), Color(0xFFE8E813),
    Color(0xFF23D5AB),  Color(0xFF23A6D5), Color(0xFFA113E8),
    Color(0xFFE73C7E)
  ];

  List<Alignment> alignmentList = [
    Alignment.bottomLeft, Alignment.bottomRight,
    Alignment.topRight, Alignment.topLeft
  ];

  int index = 0;
  Color bottomColor = const Color(0xFF453F38);
  Color topColor = const Color(0xFFE73C7E);
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () =>
      setState(() => bottomColor =const Color(0xFFEE7752))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 3),
          onEnd: () => setState(() {
            index = index + 1;
            bottomColor = colorList[index % colorList.length];
            topColor = colorList[(index + 1) % colorList.length];
          }),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: [bottomColor, topColor]
            )
          )
        )
      ]
    );
  }
}