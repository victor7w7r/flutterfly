import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';
import 'package:provider/provider.dart' show Provider;

class HomeCardBrand extends StatelessWidget {
  const HomeCardBrand ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeFluentProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Card(
      backgroundColor: themeProvider.cardColor,
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
      child: Column(
        children: [
          Text('Made with love by',
            style: TextStyle(fontFamily: 'AminaReska', color: themeProvider.invertedColor, fontSize: size.width > 960 ? 20 : 15)
          ),
          Image.asset('assets/${themeProvider.darkMode ? 'brandwhite' : 'brand'}.png', width: size.width > 960 ? 500.0 : 300.0, height: 100.0),
          Text('Happy Hacking!, Dart... Dart..',
            style: TextStyle( fontSize: size.width > 960 ? 20 : 15, color: themeProvider.invertedColor)
          ),
          const SizedBox(height: 15),
          Text('This UI is powered by',
            style: TextStyle( fontSize: size.width > 960 ? 20 : 15, color: themeProvider.invertedColor)
          ),
          const SizedBox(height: 30),
          Text('Fluent UI',
            style: TextStyle(fontSize:  size.width > 960 ? 60 : 40, color: themeProvider.invertedColor)
          ),
        ],
      )
    );
  }
}