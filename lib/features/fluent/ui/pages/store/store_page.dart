import 'dart:async' show unawaited;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/di/di.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/services/services.dart';
import 'package:flutterfly/features/common/ui/widgets/widgets.dart';
import 'package:flutterfly/features/fluent/ui/pages/store/store_widgets.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import 'package:flutterfly/features/fluent/ui/widgets/widgets.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StoreState();
}

class _StoreState extends State<StorePage> {
  final TextEditingController _txtCtl = TextEditingController();

  void _request(final BuildContext context) => _txtCtl.text.isNotEmpty
      ? inject.get<DataService>().mutate = _txtCtl.text
      : unawaited(
          showDialog(
            context: context,
            builder: (final ctx) => ContentDialog(
              title: const Text('Error'),
              content: const Text('Is empty your Text'),
              actions: [
                Button(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
          ),
        );

  @override
  void dispose() {
    _txtCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<FluentService>(
        builder: (final ctl) => ColoredBox(
          color: ctl.state.themeColor[0],
          child: n.Column([
            if (!isWeb) WindowTitleBar(isDark: ctl.state.isDark),
            const SizedBox(height: 10),
            const Header(),
            const SizedBox(height: 50),
            n.Column([
              n.Row([
                Card(
                  backgroundColor: ctl.state.themeColor[1],
                  borderRadius: BorderRadius.circular(20),
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
                  child: n.Column([
                    const SizedBox(height: 45),
                    'Write anything in this form and send!'.n
                      ..color = ctl.state.themeColor[2]
                      ..fontSize = 20,
                    const SizedBox(height: 30),
                    StoreText(ctl: _txtCtl, theme: ctl.state),
                    const SizedBox(height: 30),
                    BlurButton(
                      caption: 'Send',
                      onClick: () => _request(context),
                    ),
                    const SizedBox(height: 45),
                    ListenViewModel<DataService>(
                      builder: (final ctlData) => n.Text(
                        ctlData.state.isEmpty
                            ? 'Store state: Not yet.'
                            : 'Store state: Yes, you write. '
                                '${ctlData.state}',
                      )
                        ..fontSize = 20
                        ..color = ctl.state.themeColor[2]
                        ..n.center,
                    ),
                    const SizedBox(height: 45),
                  ]),
                ),
              ])
                ..mainAxisAlignment = MainAxisAlignment.spaceEvenly,
              const SizedBox(height: 60),
              BlurButton(
                caption: 'Go to Home',
                onClick: () => unawaited(Navigator.of(context).pushNamed('/')),
              ),
              const SizedBox(height: 40),
            ]),
          ]),
        ),
      );
}
