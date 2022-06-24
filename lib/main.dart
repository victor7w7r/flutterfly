import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutterfly/providers/providers.dart';
import 'package:flutterfly/screens/screens.dart';
import 'package:flutterfly/share_preferences/preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ThemeProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
        ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
        ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutterfly',
      initialRoute: HomeScreen.routerName,
      routes: <String, WidgetBuilder> {
        HomeScreen.routerName: ( _ ) => const HomeScreen(),
        StoreScreen.routerName: ( _ ) => const StoreScreen()
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme
    );
  }
}