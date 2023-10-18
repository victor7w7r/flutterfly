import 'dart:async' show unawaited;

import 'package:flutter/cupertino.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/features/common/providers/data.riverpod.dart';

part 'store_controller.g.dart';

final class StoreController {
  StoreController(this._ref) : txtCtl = TextEditingController();

  final StoreControllerRef _ref;

  final TextEditingController txtCtl;

  void request(final BuildContext context) => txtCtl.text.isNotEmpty
      ? _ref.read(dataProvider$.notifier).mutate = txtCtl.text
      : unawaited(showCupertinoModalPopup<void>(
          context: context,
          builder: (final ctx) => CupertinoAlertDialog(
                  title: const Text('Error'),
                  content: const Text('Is empty your TextField'),
                  actions: [
                    CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('OK'))
                  ])));
}

@riverpod
StoreController storeController(final StoreControllerRef ref) =>
    StoreController(ref);
