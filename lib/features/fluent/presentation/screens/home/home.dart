import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/extensions/extensions.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/presentation/widgets/title_bar.dart';
import 'package:flutterfly/features/fluent/presentation/screens/home/home_widgets.dart';
import 'package:flutterfly/features/fluent/presentation/widgets/widgets.dart';
import 'package:flutterfly/features/fluent/providers/fluent.riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  Color _background() =>
      ref.read(fluentProvider$).isDark ? Colors.white : Colors.black;

  void _colorChange(final String color) {
    switch (color) {
      case 'blue':
        ref.read(fluentProvider$.notifier).interpolator([
          ref.read(fluentProvider$).isDark
              ? const Color(0xFF0C4A6E)
              : const Color.fromARGB(255, 136, 202, 238),
          const Color(0xFF0369A1),
          _background(),
        ]);
      case 'violet':
        ref.read(fluentProvider$.notifier).interpolator([
          ref.read(fluentProvider$).isDark
              ? const Color(0xFF581c87)
              : const Color(0xFFD8b4FE),
          const Color(0xFF7E22CE),
          _background(),
        ]);
      case 'red':
        ref.read(fluentProvider$.notifier).interpolator([
          ref.read(fluentProvider$).isDark
              ? const Color(0xFF7F1D1D)
              : const Color(0xFFfCA5A5),
          const Color(0xFFB91C1C),
          _background(),
        ]);
      default:
        ref.read(fluentProvider$.notifier).interpolator([
          ref.read(fluentProvider$).isDark
              ? const Color(0xFF064E3B)
              : const Color(0xFF6EE7B7),
          const Color(0xFF047857),
          _background(),
        ]);
        break;
    }
  }

  Color _backSelector(final String color) => switch (color) {
        'blue' => const Color(0xFF0284C7),
        'violet' => const Color(0xFF9333EA),
        'red' => const Color(0xFFF3425B),
        _ => const Color(0xFF059669)
      };

  Color _borderSelector(final String color) => switch (color) {
        'blue' => const Color(0xAA7DD3fC),
        'violet' => const Color(0xAAD8B4FE),
        'red' => const Color(0xAAfCA5A5),
        _ => const Color(0xAA6EE7B7)
      };

  @override
  Widget build(final BuildContext context) {
    final theme = ref.watch(fluentProvider$);

    return ColoredBox(
      color: theme.themeColor[0],
      child: n.Column([
        if (!isWeb) WindowTitleBar(isDark: theme.isDark),
        const SizedBox(height: 10),
        const Header(),
        context.mWidth > 960
            ? SizedBox(
                height: context.mHeight <= 700 ? 40 : context.mHeight / 15,
              )
            : const SizedBox(height: 20),
        n.Column([
          context.mWidth > 960
              ? (n.Row(const [HomeCardBrand(), HomeCardCrypto()])
                ..mainAxisAlignment = MainAxisAlignment.spaceEvenly)
              : (n.Column(
                  const [
                    HomeCardBrand(),
                    SizedBox(height: 30),
                    HomeCardCrypto(),
                  ],
                )..mainAxisAlignment = MainAxisAlignment.spaceEvenly),
          const SizedBox(height: 40),
          BlurButton(
            caption: 'Go to Store',
            onClick: () async => Navigator.of(context).pushNamed('/store'),
          ),
          const SizedBox(height: 40),
          n.Row([
            ColorButton(
              back: _backSelector('blue'),
              border: _borderSelector('blue'),
              onClick: () => _colorChange('blue'),
            ),
            const SizedBox(width: 50),
            ColorButton(
              back: _backSelector('violet'),
              border: _borderSelector('violet'),
              onClick: () => _colorChange('violet'),
            ),
            const SizedBox(width: 50),
            ColorButton(
              back: _backSelector('red'),
              border: _borderSelector('red'),
              onClick: () => _colorChange('red'),
            ),
            const SizedBox(width: 50),
            ColorButton(
              back: _backSelector('green'),
              border: _borderSelector('green'),
              onClick: () => _colorChange('green'),
            ),
          ])
            ..mainCenter,
        ]),
      ]),
    );
  }
}
