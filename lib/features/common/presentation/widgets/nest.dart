import 'package:flutter/material.dart';

typedef NestChain = Widget Function(Widget);

class Nest extends StatelessWidget {

  final Object children;

  Nest(
    final List<NestChain> children,
    { super.key }
  ): children = children.toList();

  @override
  Widget build(context) {
    Widget next = Container();
    for (final child in (children as List<NestChain>).reversed) {
      next = child(next);
    }
    return next;
  }
}