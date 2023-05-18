import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Consumer, WidgetRef;

typedef CallRef = Widget Function(WidgetRef ref);

class AppConsumer extends StatelessWidget {

  final CallRef callRef;

  const AppConsumer(
    this.callRef,
    {super.key}
  );

  @override
  Widget build(context) => Consumer(
    builder: ((_, ref, ___) => callRef(ref))
  );
}