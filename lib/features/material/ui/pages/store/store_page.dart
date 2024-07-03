import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/di/inject.dart';
import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/material/ui/widgets/widgets.dart';

final class StorePage extends StatefulWidget {
  const StorePage({super.key, this.child, this.secondMockChild});

  final Widget? child;
  final Widget? secondMockChild;

  @override
  State<StorePage> createState() => _StoreState();
}

final class _StoreState extends State<StorePage> {
  final TextEditingController _txtCtl = TextEditingController();

  void _request(
    final BuildContext context,
  ) =>
      _txtCtl.text.isNotEmpty
          ? inject.get<DataService>().mutate = _txtCtl.text
          : unawaited(
              showDialog(
                context: context,
                builder: (final ctx) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Is empty your TextField'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, 'OK'),
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
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: NavBar('My Store', child: widget.secondMockChild),
          ),
          drawer: inject.get<Platform>().isMacOS() ? null : const DrawerMenu(),
          endDrawer:
              inject.get<Platform>().isMacOS() ? const DrawerMenu() : null,
          body: n.Column([
            'Store Example'.n
              ..freezed
              ..fontSize = context.isMinMd ? 25 : 40
              ..n.center,
            const SizedBox(height: 15),
            'Write anything in this form and send!'.n
              ..freezed
              ..fontSize = context.isMinMd ? 15 : 20
              ..n.center,
            const SizedBox(height: 25),
            TextField(
              cursorHeight: 25,
              controller: _txtCtl,
              decoration: const InputDecoration(
                hintText: 'here',
                border: OutlineInputBorder(),
              ),
            ).niku
              ..w = 250.0
              ..h = 55.0,
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _request(context),
              child: const Text('SUBMIT'),
            ),
            const SizedBox(height: 10),
            ListenViewModel<DataService>(
              builder: (final ctl) => n.Text(
                ctl.state().isEmpty
                    ? 'Store state: Not yet.'
                    : 'Store state: Yes, you write. ${ctl.state}',
              )
                ..fontSize = 15
                ..n.center,
            ),
          ])
            ..mainCenter
            ..crossCenter,
        ),
      );
}
