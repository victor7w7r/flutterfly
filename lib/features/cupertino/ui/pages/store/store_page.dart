import 'dart:async' show unawaited;

import 'package:flutter/cupertino.dart';

import 'package:get_it/get_it.dart' show GetIt;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/theme_toggle.dart';

final class StorePage extends StatefulWidget {
  const StorePage({super.key, this.child});

  final Widget? child;

  @override
  State<StorePage> createState() => _StoreState();
}

final class _StoreState extends State<StorePage> {
  final TextEditingController _txtCtl = TextEditingController();

  void _request(
    final BuildContext context,
  ) =>
      _txtCtl.text.isNotEmpty
          ? GetIt.I<DataService>().mutate = _txtCtl.text
          : unawaited(
              showCupertinoModalPopup<void>(
                context: context,
                builder: (final ctx) => CupertinoAlertDialog(
                  title: const Text('Error'),
                  content: const Text('Is empty your TextField'),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(ctx),
                      isDefaultAction: true,
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
  Widget build(final BuildContext context) =>
      widget.child ??
      GestureDetector(
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: n.Stack([
          const ThemeToggle().niku
            ..niku.top = 70
            ..niku.right = 0,
          n.Column([
            'Store Example'.n
              ..fontSize = context.isMinMd ? 25 : 40
              ..freezed
              ..n.center,
            const SizedBox(height: 15),
            'Write anything in this form and send!'.n
              ..fontSize = context.isMinMd ? 15 : 20
              ..freezed
              ..n.center,
            const SizedBox(height: 25),
            ListenViewModel<CupertinoService>(
              builder: (final ctl) => CupertinoTextField(
                controller: _txtCtl,
                decoration: BoxDecoration(
                  color: ctl.isDark
                      ? const Color.fromARGB(255, 43, 53, 69)
                      : const Color.fromARGB(255, 248, 250, 253),
                ),
                placeholder: 'here',
                cursorHeight: 25,
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
            ListenViewModel<DataService>(
              builder: (final ctl) => n.Text(
                ctl.state.isEmpty
                    ? 'Store state: Not yet.'
                    : 'Store state: Yes, you write. ${ctl.state}',
              )
                ..fontSize = 15
                ..n.center,
            ),
          ])
            ..mainCenter
            ..crossCenter,
        ]),
      );
}
