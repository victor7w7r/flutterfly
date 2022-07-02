import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart' show AutoRouter;

class Flutterfly extends StatefulWidget {
  const Flutterfly({Key? key}) : super(key: key);

  @override
  State<Flutterfly> createState() => _FlutterflyState();
}

class _FlutterflyState extends State<Flutterfly> {

  @override
  Widget build(BuildContext context) => const AutoRouter();
}