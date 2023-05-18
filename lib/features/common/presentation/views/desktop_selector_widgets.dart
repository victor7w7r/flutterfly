import 'package:fluent_ui/fluent_ui.dart';

import 'package:nester/nester.dart' show Nester;
import 'package:niku/namespace.dart' as n;

import 'package:tailwind_colors/tailwind_colors.dart' show TWTwoColors;

final class MenuBuilder extends StatelessWidget {

  final String title;
  final String image;
  final VoidCallback onTap;

  const MenuBuilder({
    super.key,
    required this.title,
    required this.image,
    required this.onTap
  });

  @override
  Widget build(context) => n.Column([
    title.n
      ..fontSize = 30
      ..fontFamily = 'AminaReska'
      ..color = TWTwoColors.gray.shade100,
    Nester.list([
      (next) => GestureDetector(
        onTap: onTap, child: next
      ), (next) => ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: next
      ), (next) => SizedBox.fromSize(
        size: const Size.fromRadius(120),
        child: next
      ), (_) => Image.asset(
        'assets/$image.jpg',
        fit: BoxFit.cover
      )
    ])
  ]);
}