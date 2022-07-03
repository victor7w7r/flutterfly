import 'package:fluent_ui/fluent_ui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutterfly/modules/fluent/widgets/blur_button.dart';
import 'package:flutterfly/modules/fluent/widgets/color_button.dart';

import 'package:flutterfly/modules/fluent/widgets/header.dart';
import 'package:flutterfly/modules/fluent/widgets/home_card_brand.dart';
import 'package:flutterfly/modules/fluent/widgets/home_card_crypto.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                children: const [HomeCardBrand(), HomeCardCrypto()]
              ),
              const SizedBox(height: 60),
              BlurButton(caption: 'Go to store', onClick:() => context.navigateNamedTo('/store')),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorButton(color: 'blue', onClick: () =>{}),
                  const SizedBox(width: 50),
                  ColorButton(color: 'violet', onClick: () =>{}),
                  const SizedBox(width: 50),
                  ColorButton(color: 'red', onClick: () =>{}),
                  const SizedBox(width: 50),
                  ColorButton(color: 'green', onClick: () =>{}),
                ]
              )
            ]
          )
        ]
      )
    );
  }
}