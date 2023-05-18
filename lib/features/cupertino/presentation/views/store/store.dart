import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/features/common/data/providers/data_provider.dart';
import 'package:flutterfly/features/common/presentation/widgets/consumer.dart';
import 'package:flutterfly/features/cupertino/data/providers/cupertino_provider.dart';
import 'package:flutterfly/features/cupertino/presentation/views/store/store_controller.dart';
import 'package:flutterfly/features/cupertino/presentation/widgets/theme_toggle.dart';

final class Store extends StatelessWidget {

  const Store({super.key});

  @override
  Widget build(context) {

    final ctl = context.read(storeController);

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: n.Stack([
        const ThemeToggle().niku
          ..niku.top = 70
          ..niku.right = 0,
        n.Column([
          'Store Example'.n
            ..fontSize = 40
            ..freezed
            ..n.center,
          const SizedBox(height: 15),
          'Write anything in this form and send!'.n
            ..fontSize = 20
            ..freezed
            ..n.center,
          const SizedBox(height: 25),
          AppConsumer((ref) => CupertinoTextField(
            placeholder: 'here',
            cursorHeight: 25,
            controller: ctl.txtCtl,
            decoration: BoxDecoration(
              color: ref.watch(cupertinoProvider)
                ? TWColors.gray.shade800
                : TWColors.gray.shade300,
              )
            ).niku
            ..w = 250.0
            ..h = 55.0
          ),
          const SizedBox(height: 12),
          CupertinoButton.filled(
            onPressed: () => ctl.request(context),
            child: const Text('SUBMIT')
          ),
          const SizedBox(height: 20),
          AppConsumer((ref) {
            final data = ref.watch(dataProvider);
            return n.Text(data.isEmpty
              ? 'Store state: Not yet.'
              : 'Store state: Yes, you write. $data'
            )
              ..fontSize = 15
              ..n.center;
          })
        ])
          ..mainCenter
          ..crossCenter
      ])
    );
  }
}