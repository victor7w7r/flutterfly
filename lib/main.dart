import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/widgets.dart';

import 'package:flutterfly/platforms/platforms.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(defaultTargetPlatform == TargetPlatform.iOS) {
      return cupertinoApp(context);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return materialApp(context);
    } else {
      return fluentApp(context);
    }
  }
}