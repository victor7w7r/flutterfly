import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Consumer;
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/modules/common/providers/data_provider.dart';
import 'package:flutterfly/modules/material/widgets/index.dart';
import 'package:flutterfly/modules/material/views/store/store_controller.dart';
import 'package:flutterfly/utils/platforms.dart';

class Store extends StatelessWidget {

  const Store({super.key});

  @override
  Widget build(context) {

    final ctl = context.read(storeController);

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        appBar: appBar("My Store"),
        drawer: isMacOS ? null : const DrawerMenu(),
        endDrawer: isMacOS ? const DrawerMenu() : null,
        body: n.Column([
          "Store Example".n
            ..freezed
            ..fontSize = 40
            ..n.center,
          const SizedBox(height: 15),
          "Write anything in this form and send!".n
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
          Consumer(builder: (_, ref, __) {
            final data = ref.watch(dataProvider);
            return n.Text(data.isEmpty
              ? "Store state: Not yet."
              : "Store state: Yes, you write. $data"
            )
              ..fontSize = 15
              ..n.center;
          })
        ])
          ..mainAxisAlignment = MainAxisAlignment.center
          ..crossAxisAlignment = CrossAxisAlignment.center,
      )
    );
  }
}