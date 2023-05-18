import 'package:fluent_ui/fluent_ui.dart';

import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/index.dart';
import 'package:flutterfly/config/extensions/extensions.dart';
import 'package:flutterfly/features/common/presentation/widgets/title_bar.dart';
import 'package:flutterfly/features/fluent/data/providers/fluent_provider.dart';
import 'package:flutterfly/features/fluent/presentation/views/home/home_controller.dart';
import 'package:flutterfly/features/fluent/presentation/views/home/home_widgets.dart';
import 'package:flutterfly/features/fluent/presentation/widgets/widgets.dart';

class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(context) {

    final theme = context.watch(fluentProvider);

    final ctl = context.read(homeController);

    return Container(
      color: theme.themeColor[0],
      child: n.Column([
        if(!isWeb) WindowTitleBar(isDark: theme.isDark),
        const SizedBox(height: 10),
        const Header(),
        context.mWidth > 960
          ? SizedBox(height: context.mHeight <= 700
            ? 40
            : context.mHeight / 15)
          : const SizedBox(height: 20),
        n.Column([
          context.mWidth > 960 ? (
            n.Row(const [HomeCardBrand(), HomeCardCrypto()])
              ..mainAxisAlignment = MainAxisAlignment.spaceEvenly
          ) : (
            n.Column(const [
              HomeCardBrand(),
              SizedBox(height: 30),
              HomeCardCrypto()
            ])
              ..mainAxisAlignment =  MainAxisAlignment.spaceEvenly
          ),
          const SizedBox(height: 40),
          BlurButton(
            caption: 'Go to Store',
            onClick: () => Navigator.of(context).pushNamed('/store')
          ),
          const SizedBox(height: 40),
          n.Row([
            ColorButton(
              back: ctl.backSelector('blue'),
              border: ctl.borderSelector('blue'),
              onClick: () => ctl.colorChange('blue')
            ),
            const SizedBox(width: 50),
            ColorButton(
              back: ctl.backSelector('violet'),
              border: ctl.borderSelector('violet'),
              onClick: () => ctl.colorChange('violet')
            ),
            const SizedBox(width: 50),
            ColorButton(
              back: ctl.backSelector('red'),
              border: ctl.borderSelector('red'),
              onClick: () => ctl.colorChange('red')
            ),
            const SizedBox(width: 50),
            ColorButton(
              back: ctl.backSelector('green'),
              border: ctl.borderSelector('green'),
              onClick: () => ctl.colorChange('green')
            ),
          ])
            ..mainCenter
        ])
      ])
    );
  }
}