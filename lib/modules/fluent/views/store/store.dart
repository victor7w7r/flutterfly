import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/modules/common/providers/data_provider.dart';
import 'package:flutterfly/modules/common/widgets/title_bar.dart';
import 'package:flutterfly/modules/fluent/providers/fluent_provider.dart';
import 'package:flutterfly/modules/fluent/views/store/store_widgets.dart';
import 'package:flutterfly/modules/fluent/views/store/store_controller.dart';
import 'package:flutterfly/modules/fluent/widgets/index.dart';
import 'package:flutterfly/utils/platforms.dart';

class Store extends StatelessWidget {

  const Store({super.key});

  @override
  Widget build(context) {

    final theme = context.watch(fluentProvider);

    final ctl = context.read(storeController);

    return Container(
      color: theme.themeColor[0],
      child: n.Column([
        if(!isWeb) WindowTitleBar(isDark: theme.darkMode),
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
              Consumer(builder: (_, ref, __) {
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