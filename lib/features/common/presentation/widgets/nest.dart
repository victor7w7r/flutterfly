import 'package:flutter/material.dart';

typedef NestChain = Widget Function(Widget);

class Nest extends StatelessWidget {

  Nest(
    final List<NestChain> children,
    { super.key }
  ): children = children.toList();

  final Object children;

  @override
  Widget build(final BuildContext context) {
    Widget next = Container();
    for (final child in (children as List<NestChain>).reversed) {
      next = child(next);
    }
    return next;
  }
}
