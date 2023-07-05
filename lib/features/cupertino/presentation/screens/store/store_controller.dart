import 'package:flutter/cupertino.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/features/common/providers/data_provider.dart';

part 'store_controller.g.dart';

final class StoreController {

  final ProviderRef _ref;

  final TextEditingController txtCtl;

  StoreController(this._ref):
    txtCtl = TextEditingController();

  void request(
    final BuildContext context
  ) => txtCtl.text.isNotEmpty
    ? _ref.read(dataProvider$.notifier)
        .mutate(txtCtl.text)
    : showCupertinoModalPopup<void> (
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: const Text('Is empty your TextField'),
        actions: [CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(ctx),
          child: const Text('OK')
        )]
      )
    );
}

@riverpod
StoreController storeController(
  final StoreControllerRef ref
) => StoreController(ref);