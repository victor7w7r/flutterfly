import 'package:flutter/material.dart';

import '../widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {

  static const String routerName = 'Home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Home'),
          elevation: 0.0
      ),
      drawer: const DrawerMenu(),
      body: OrientationBuilder(   
        builder:(context, orientation) {
          return GridView.count( 
            crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
              //physics: const NeverScrollableScrollPhysics(),
            children: [ 
              Column(
                children: const [
                  SizedBox(height: 50),
                  LogoChip(),
                  SizedBox(height: 15),
                  Center(child: Text("Happy Hacking!, Dart... Dart...", style: TextStyle(fontSize: 30))),
                  SizedBox(height: 10),
                  Center(child: Text("Store State: Not yet", style: TextStyle(fontSize: 20)))
                ],
              )
            ]
          );
        }
      )
    );
  }
}

class LogoChip extends StatelessWidget {
  const LogoChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 50,
      child: Row(
        children: [
          Image.asset('assets/flutter-logo.png', width: 58.0, height: 35.0),
          const Text('Flutter Material Template', style: TextStyle(fontSize: 20) )
        ]
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 2,
        )
      ),
    );
  }
}