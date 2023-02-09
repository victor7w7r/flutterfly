import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider, ProviderRef;

import 'package:flutterfly/modules/common/providers/data_provider.dart';

class StoreController {

  StoreController(this.ref);

  final ProviderRef ref;

  final txtCtl = TextEditingController();

  void request(BuildContext context) => txtCtl.text.isNotEmpty
    ? ref.read(dataProvider.notifier).state = txtCtl.text
    : showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Is empty your TextField'),
        actions: [TextButton(
          onPressed: () => Navigator.pop(ctx, 'OK'),
          child: const Text('OK')
        )]
      )
    );
}

final storeController = Provider(StoreController.new);