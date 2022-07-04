import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';

import 'package:flutterfly/modules/fluent/widgets/blur_button.dart';
import 'package:flutterfly/modules/fluent/widgets/header.dart';
import 'package:flutterfly/modules/fluent/widgets/store_card.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Container (
      color: const Color(0xFF18171C),
      child: Column(
        children:  [
          const SizedBox(height: 10),
          const Header(),
          const SizedBox(height: 50),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [const StoreCard()]
              ),
              const SizedBox(height: 60),
              BlurButton(caption: 'Go to Home', onClick:() => context.navigateNamedTo('/home')),
              const SizedBox(height: 40),
            ]
          )
        ]
      )
    );
  }
}