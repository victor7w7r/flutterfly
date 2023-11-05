import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/features/common/providers/data.riverpod.dart';

part 'store_controller.g.dart';

final class StoreController {
  StoreController(this._ref) : txtCtl = TextEditingController();

  final StoreControllerRef _ref;
  final TextEditingController txtCtl;

  void request(final BuildContext context) => txtCtl.text.isNotEmpty
      ? _ref.read(dataProvider$.notifier).mutate = txtCtl.text
      : unawaited(
          showDialog(
            context: context,
            builder: (final ctx) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Is empty your TextField'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
}

@riverpod
StoreController storeController(final StoreControllerRef ref) =>
    StoreController(ref);
