import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Consumer;
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/modules/common/providers/data_provider.dart';
import 'package:flutterfly/modules/cupertino/providers/cupertino_provider.dart';
import 'package:flutterfly/modules/cupertino/views/store/store_controller.dart';
import 'package:flutterfly/modules/cupertino/widgets/theme_toggle.dart';

class Store extends StatelessWidget {

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
          Consumer(builder: (_, ref, __) => CupertinoTextField(
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
          Consumer(builder: (_, ref, __) {
            final data = ref.watch(dataProvider);
            return n.Text(data.isEmpty
              ? 'Store state: Not yet.'
              : 'Store state: Yes, you write. $data'
            )
              ..fontSize = 15
              ..n.center;
          })
        ])
          ..mainAxisAlignment = MainAxisAlignment.center
          ..crossAxisAlignment= CrossAxisAlignment.center
      ])
    );
  }
}