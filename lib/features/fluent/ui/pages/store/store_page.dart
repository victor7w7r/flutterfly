import 'dart:async' show unawaited;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/utils.dart';
import 'package:flutterfly/features/common/ui/services/services.dart';
import 'package:flutterfly/features/common/ui/widgets/widgets.dart';
import 'package:flutterfly/features/fluent/ui/pages/store/store_widgets.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import 'package:flutterfly/features/fluent/ui/widgets/widgets.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key, this.child, this.secondMockChild});

  final Widget? child;
  final Widget? secondMockChild;

  @override
  State<StorePage> createState() => _StoreState();
}

class _StoreState extends State<StorePage> {
  final TextEditingController _txtCtl = TextEditingController();

  void _request(final BuildContext context) => _txtCtl.text.isNotEmpty
      ? GetIt.I<DataService>().mutate = _txtCtl.text
      : unawaited(
          showDialog(
            context: context,
            builder: (final ctx) => ContentDialog(
              title: const Text('Error'),
              content: const Text('Is empty your Text'),
              actions: [
                Button(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('OK'),
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
      widget.child ??
      ListenViewModel<FluentService>(
        builder: (final ctl) => ColoredBox(
          color: ctl.state.themeColor.first,
          child: n.Column([
            if (!GetIt.I<Platform>().isWeb)
              WindowTitleBar(
                isDark: ctl.state.isDark,
                child: widget.secondMockChild,
              ),
            const SizedBox(height: 10),
            Header(child: widget.secondMockChild),
            const SizedBox(height: 50),
            n.Column([
              n.Row([
                Card(
                  padding: EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: context.isMinMd ? 20 : 50,
                  ),
                  backgroundColor: ctl.state.themeColor[1],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: n.Column([
                    const SizedBox(height: 45),
                    'Write anything in this form and send!'.n
                      ..color = ctl.state.themeColor[2]
                      ..overflow = TextOverflow.ellipsis
                      ..fontSize = 17,
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
                        ..fontSize = 17
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
