import 'package:flutter/widgets.dart';

class HomeLogoChip extends StatelessWidget {
  const HomeLogoChip({Key? key, required this.value}) : super(key: key);

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: value
          ? Border.all(width: 2, color: const Color.fromRGBO(255, 255, 255, 1))
          : Border.all(width: 2, color: const Color.fromRGBO(0, 0, 0, 1))
      ),
      child: Row(
        children: [
          Image.asset('assets/flutter-logo.png', width: 77.0, height: 35.0),
          const Text('Flutter Template', style: TextStyle(fontSize: 20))
        ]
      )
    );
  }
}