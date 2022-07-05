import 'package:flutter/widgets.dart';

class HomeBrandChip extends StatelessWidget {

  const HomeBrandChip({Key? key, required this.value}) : super(key: key);

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: value
          ? Border.all(width: 2, color: const Color.fromRGBO(255, 255, 255, 1))
          : Border.all(width: 2, color: const Color.fromRGBO(0, 0, 0, 1))
      ),
      child: Row(
        children: [
          const SizedBox(width: 38),
          Image.asset(value ? 'assets/brandwhite.png' : 'assets/brand.png', width: 220.0, height: 70.0)
        ]
      )
    );
  }
}