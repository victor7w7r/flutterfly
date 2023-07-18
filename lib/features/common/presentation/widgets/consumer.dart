import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Consumer, WidgetRef;

typedef CallRef = Widget Function(WidgetRef ref);

final class AppConsumer extends StatelessWidget {

  const AppConsumer(
    this.callRef,
    {super.key}
  );

  final CallRef callRef;

  @override
  Widget build(
    final BuildContext context
  ) => Consumer(
    builder: (final _, final ref, final ___) => callRef(ref)
  );
}