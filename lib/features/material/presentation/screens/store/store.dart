import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/presentation/widgets/consumer.dart';
import 'package:flutterfly/features/common/providers/data_provider.dart';
import 'package:flutterfly/features/material/presentation/screens/store/store_controller.dart';
import 'package:flutterfly/features/material/presentation/widgets/widgets.dart';

final class Store extends ConsumerWidget {

  const Store({super.key});

  @override
  Widget build(
    final BuildContext context,
    final WidgetRef ref
  ) {

    final ctl = ref.read(storeController$);

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: NavBar('My Store')
        ),
        drawer: isMacOS
          ? null : const DrawerMenu(),
        endDrawer: isMacOS
          ? const DrawerMenu() : null,
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
            controller: ctl.txtCtl,
            decoration: const InputDecoration(
              hintText: 'here',
              border: OutlineInputBorder()
            )
          ).niku
            ..w = 250.0
            ..h = 55.0,
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => ctl.request(context),
            child: const Text('SUBMIT')
          ),
          const SizedBox(height: 10),
          AppConsumer((final ref) {
            final data = ref.watch(dataProvider$);
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
      )
    );
  }
}