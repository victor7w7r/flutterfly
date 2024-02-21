import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/presentation/widgets/consumer.dart';
import 'package:flutterfly/features/common/providers/data.riverpod.dart';
import 'package:flutterfly/features/material/presentation/widgets/widgets.dart';

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
  Widget build(final BuildContext context) => GestureDetector(
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: NavBar('My Store'),
          ),
          drawer: isMacOS ? null : const DrawerMenu(),
          endDrawer: isMacOS ? const DrawerMenu() : null,
          body: n.Column([
            'Store Example'.n
              ..freezed
              ..fontSize = 40
              ..n.center,
            const SizedBox(height: 15),
            'Write anything in this form and send!'.n
              ..freezed
              ..fontSize = 20
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
        ),
      );
}
