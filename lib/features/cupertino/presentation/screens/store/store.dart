import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/features/common/presentation/widgets/consumer.dart';
import 'package:flutterfly/features/common/providers/data.riverpod.dart';
import 'package:flutterfly/features/cupertino/presentation/screens/store/store_controller.dart';
import 'package:flutterfly/features/cupertino/presentation/widgets/theme_toggle.dart';
import 'package:flutterfly/features/cupertino/providers/cupertino.riverpod.dart';

final class Store extends ConsumerWidget {
  const Store({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ctl = ref.read(storeController$);

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
          AppConsumer(
            (final ref) => CupertinoTextField(
              placeholder: 'here',
              cursorHeight: 25,
              controller: ctl.txtCtl,
              decoration: BoxDecoration(
                color: ref.watch(cupertinoProvider$)
                    ? TWColors.gray.shade800
                    : TWColors.gray.shade300,
              ),
            ).niku
              ..w = 250.0
              ..h = 55.0,
          ),
          const SizedBox(height: 12),
          CupertinoButton.filled(
            onPressed: () => ctl.request(context),
            child: const Text('SUBMIT'),
          ),
          const SizedBox(height: 20),
          AppConsumer((final ref) {
            final data = ref.watch(dataProvider$);
            return n.Text(
              data.isEmpty
                  ? 'Store state: Not yet.'
                  : 'Store state: Yes, you write. $data',
            )
              ..fontSize = 15
              ..n.center;
          }),
        ])
          ..mainCenter
          ..crossCenter,
      ]),
    );
  }
}
