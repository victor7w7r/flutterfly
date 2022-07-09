import 'package:fluent_ui/fluent_ui.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/fluent_provider.dart';

import 'package:flutterfly/modules/fluent/screens/home_screen.dart';

import 'package:flutterfly/modules/fluent/widgets/widgets.dart';

class StoreScreen extends StatefulWidget {

  const StoreScreen({Key? key}) : super(key: key);

  static const String routerName = 'Store';

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<FluentProvider>(context, listen: true);
    return Container (
      color: themeProvider.backgroundColor,
      child: Column(
        children: [
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
              BlurButton(
                caption: 'Go to Home',
                onClick: () =>  Navigator.pushReplacementNamed(context, HomeScreen.routerName)
              ),
              const SizedBox(height: 40)
            ]
          )
        ]
      )
    );
  }
}