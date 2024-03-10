import 'package:flutter/cupertino.dart';

CupertinoApp cupertinoApp(
  final BuildContext context,
) =>
    const CupertinoApp(
      title: 'flutterfly',
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(child: Center(child: Text('Awesome'))),
    );
