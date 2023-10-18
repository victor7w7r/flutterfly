import 'package:fluent_ui/fluent_ui.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tailwind_colors/tailwind_colors.dart' show TWTwoColors;

import 'package:flutterfly/features/common/presentation/widgets/widgets.dart';

final class MenuBuilder extends StatelessWidget {
  const MenuBuilder(
      {required this.title,
      required this.image,
      required this.onTap,
      super.key});

  final String image;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(final BuildContext context) => n.Column([
        title.n
          ..fontSize = 30
          ..fontFamily = 'AminaReska'
          ..color = TWTwoColors.gray.shade100,
        Nest([
          (final next) => GestureDetector(onTap: onTap, child: next),
          (final next) =>
              ClipRRect(borderRadius: BorderRadius.circular(20.0), child: next),
          (final next) =>
              SizedBox.fromSize(size: const Size.fromRadius(120), child: next),
          (final _) => Image.asset('assets/$image.jpg', fit: BoxFit.cover)
        ])
      ]);
}
