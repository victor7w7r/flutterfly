import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutterfly/modules/common/providers/data_provider.dart';

class StoreController {

  StoreController(this.ref);

  final ProviderRef ref;

  final txtCtl = TextEditingController();

  void request(BuildContext context) => txtCtl.text.isNotEmpty
    ? ref.read(dataProvider.notifier).state = txtCtl.text
    : showCupertinoModalPopup<void> (
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: const Text('Is empty your TextField'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK')
          )
        ]
      )
    );
}

final storeController = Provider(StoreController.new);