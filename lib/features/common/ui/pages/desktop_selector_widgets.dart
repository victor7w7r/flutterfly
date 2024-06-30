import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/features/common/ui/widgets/widgets.dart';

final class MenuBuilder extends StatelessWidget {
  const MenuBuilder({
    required this.title,
    required this.image,
    required this.onTap,
    super.key,
  });

  final String image;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(final BuildContext context) => n.Column([
        title.n
          ..fontSize = 30
          ..fontFamily = 'AminaReska'
          ..color = Colors.white,
        Nest([
          (final next) => GestureDetector(onTap: onTap, child: next),
          (final next) => ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: next,
              ),
          (final next) =>
              SizedBox.fromSize(size: const Size.fromRadius(120), child: next),
          (final _) => Image.asset('assets/$image.jpg', fit: BoxFit.cover),
        ]),
      ]);
}
