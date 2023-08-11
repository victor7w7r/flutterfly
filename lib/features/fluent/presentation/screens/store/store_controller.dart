import 'dart:async' show unawaited;

import 'package:fluent_ui/fluent_ui.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/features/common/providers/data.riverpod.dart';

part 'store_controller.g.dart';

final class StoreController {

  StoreController(this._ref):
    txtCtl = TextEditingController();

  final StoreControllerRef _ref;
  final TextEditingController txtCtl;

  void request(
    final BuildContext context
  ) => txtCtl.text.isNotEmpty
    ? _ref.read(dataProvider$.notifier).mutate = txtCtl.text
    : unawaited(showDialog(
      context: context,
      builder: (final ctx) => ContentDialog(
        title: const Text('Error'),
        content: const Text('Is empty your Text'),
        actions: [Button(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(ctx)
        )]
      )
    ));
}

@riverpod
StoreController storeController(
  final StoreControllerRef ref
) => StoreController(ref);
