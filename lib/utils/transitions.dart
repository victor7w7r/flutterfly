import 'package:flutter/widgets.dart'
  show Widget, SlideTransition, FadeTransition,
    BuildContext, Animation, Tween, Offset;

SlideTransition materialTransition(BuildContext context, Animation<double> a1, Animation<double> a2, Widget child) {
  return SlideTransition(
    position: Tween(
      begin: const Offset(0.0, 0.2),
      end: const Offset(0.0, 0.0)).animate(a1),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.4, end: 1.0).animate(a1),
        child: child
      )
  );
}