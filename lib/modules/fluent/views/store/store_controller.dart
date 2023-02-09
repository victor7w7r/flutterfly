import 'package:fluent_ui/fluent_ui.dart';

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
      builder: (ctx) => ContentDialog(
        title: const Text('Error'),
        content: const Text('Is empty your Text'),
        actions: [Button(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(ctx)
        )]
      )
    );

}

final storeController = Provider(StoreController.new);