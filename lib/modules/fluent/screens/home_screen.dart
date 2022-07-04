import 'package:fluent_ui/fluent_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';
import 'package:provider/provider.dart' show Provider;

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
    final themeProvider = Provider.of<ThemeFluentProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Container (
      color: themeProvider.backgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Header(),
          size.width > 960
            ? SizedBox(height: size.height <= 700 ? 40 : size.height / 15 )
            : const SizedBox(height: 20),
          Column(
            children: [
            size.width > 960 ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [HomeCardBrand(), HomeCardCrypto()]
                ) :
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [HomeCardBrand(), SizedBox(height: 30),  HomeCardCrypto()]
                ),
              const SizedBox(height: 40),
              BlurButton(caption: 'Go to Store', onClick:() => context.navigateNamedTo('/store')),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ColorButton(color: 'blue'),
                  SizedBox(width: 50),
                  ColorButton(color: 'violet'),
                  SizedBox(width: 50),
                  ColorButton(color: 'red'),
                  SizedBox(width: 50),
                  ColorButton(color: 'green')
                ]
              )
            ]
          )
        ]
      )
    );
  }
}