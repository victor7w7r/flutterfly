import 'package:flutter/widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';
import 'package:provider/provider.dart' show Provider;

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
    final themeProvider = Provider.of<ThemeFluentProvider>(context, listen: true);
    return Container (
      color: themeProvider.backgroundColor,
      child: Column(
        children:  [
          const SizedBox(height: 10),
          const Header(),
          const SizedBox(height: 50),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [StoreCard()],
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