import 'package:flutter/cupertino.dart';

CupertinoApp cupertinoApp(BuildContext context) {
  return const CupertinoApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      child: Center(
        child: Text('Awesome')
      )
    )
  );
}