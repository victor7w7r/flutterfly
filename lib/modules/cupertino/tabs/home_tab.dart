import 'package:flutter/cupertino.dart';
import 'package:flutterfly/modules/material/widgets/home_logo_chip.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return const HomeLogoChip(value: true);
  }
}