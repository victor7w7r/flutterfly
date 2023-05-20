import 'package:fluent_ui/fluent_ui.dart';

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
    ? _ref.read(dataProvider.notifier).state = txtCtl.text
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