import 'package:fluent_ui/fluent_ui.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/mvvm/base_mvvm.dart';
import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/features/common/ui/widgets/nest.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';

final class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<FluentService>(
        builder: (final ctl) => Nest([
          (final next) => Card(
                backgroundColor: ctl.state.themeColor[1],
                borderRadius: BorderRadius.circular(20),
                child: next,
              ),
          (final next) => FractionallySizedBox(widthFactor: 0.98, child: next),
          (final _) => n.Row([
                n.Row([
                  n.Image.asset('assets/flutter-logo.png')
                    ..width = 50
                    ..height = 30,
                  'Flutter Template'.n..color = ctl.state.themeColor[2],
                ])
                  ..pl = context.mWidth > 960 ? 200 : 50,
                ToggleSwitch(
                  checked: ctl.state.isDark,
                  onChanged: ctl.toggle,
                  content: 'Dark Mode'.n..color = ctl.state.themeColor[2],
                ).niku
                  ..pr = context.mWidth > 960 ? 200 : 50,
              ])
                ..mainAxisAlignment = MainAxisAlignment.spaceBetween,
        ]),
      );
}
