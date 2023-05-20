import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider, ProviderRef;

import 'package:flutterfly/features/common/data/providers/data_provider.dart';

final class StoreController {

  final ProviderRef _ref;
  final TextEditingController txtCtl;

  StoreController(this._ref):
    txtCtl = TextEditingController();

  void request(
    final BuildContext context
  ) => txtCtl.text.isNotEmpty
    ? _ref.read(dataProvider.notifier)
        .state = txtCtl.text
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

final storeController = Provider(
  StoreController.new
);