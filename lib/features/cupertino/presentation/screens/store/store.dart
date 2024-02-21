import 'dart:async' show unawaited;

import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/features/common/presentation/widgets/consumer.dart';
import 'package:flutterfly/features/common/providers/data.riverpod.dart';
import 'package:flutterfly/features/cupertino/presentation/widgets/theme_toggle.dart';
import 'package:flutterfly/features/cupertino/providers/cupertino.riverpod.dart';

class Store extends ConsumerStatefulWidget {
  const Store({super.key});

  @override
  ConsumerState<Store> createState() => _StoreState();
}

class _StoreState extends ConsumerState<Store> {
  final TextEditingController _txtCtl = TextEditingController();

  void _request(final BuildContext context) => _txtCtl.text.isNotEmpty
      ? ref.read(dataProvider$.notifier).mutate = _txtCtl.text
      : unawaited(
          showCupertinoModalPopup<void>(
            context: context,
            builder: (final ctx) => CupertinoAlertDialog(
              title: const Text('Error'),
              content: const Text('Is empty your TextField'),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
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
  Widget build(final BuildContext context) => GestureDetector(
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
                controller: _txtCtl,
                decoration: BoxDecoration(
                  color: ref.watch(cupertinoProvider$)
                      ? const Color.fromARGB(255, 43, 53, 69)
                      : const Color.fromARGB(255, 248, 250, 253),
                ),
              ).niku
                ..w = 250.0
                ..h = 55.0,
            ),
            const SizedBox(height: 12),
            CupertinoButton.filled(
              onPressed: () => _request(context),
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
