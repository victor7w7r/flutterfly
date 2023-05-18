import 'package:fluent_ui/fluent_ui.dart';

import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/data/providers/providers.dart';
import 'package:flutterfly/features/common/presentation/widgets/widgets.dart';
import 'package:flutterfly/features/fluent/data/providers/fluent_provider.dart';
import 'package:flutterfly/features/fluent/presentation/views/store/store_controller.dart';
import 'package:flutterfly/features/fluent/presentation/views/store/store_widgets.dart';
import 'package:flutterfly/features/fluent/presentation/widgets/widgets.dart';

class Store extends StatelessWidget {

  const Store({super.key});

  @override
  Widget build(context) {

    final theme = context.watch(fluentProvider);

    final ctl = context.read(storeController);

    return Container(
      color: theme.themeColor[0],
      child: n.Column([
        if(!isWeb) WindowTitleBar(isDark: theme.isDark),
        const SizedBox(height: 10),
        const Header(),
        const SizedBox(height: 50),
        n.Column([
          n.Row([Card(
            backgroundColor: theme.themeColor[1],
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
            child: n.Column([
              const SizedBox(height: 45),
              'Write anything in this form and send!'.n
                ..color = theme.themeColor[2]
                ..fontSize = 20,
              const SizedBox(height: 30),
              StoreText(ctl: ctl.txtCtl, theme: theme),
              const SizedBox(height: 30),
              BlurButton(
                caption: 'Send',
                onClick: () => ctl.request(context)
              ),
              const SizedBox(height: 45),
              AppConsumer((ref) {
                final data = ref.watch(dataProvider);
                return n.Text(data.isEmpty
                  ? 'Store state: Not yet.'
                  : 'Store state: Yes, you write. $data'
                )
                  ..fontSize = 20
                  ..color = theme.themeColor[2]
                  ..n.center;
              }),
              const SizedBox(height: 45)
            ])
          )])
            ..mainAxisAlignment = MainAxisAlignment.spaceEvenly,
          const SizedBox(height: 60),
          BlurButton(
            caption: 'Go to Home',
            onClick: () => Navigator.of(context).pushNamed('/')
          ),
          const SizedBox(height: 40)
        ])
      ])
    );
  }
}