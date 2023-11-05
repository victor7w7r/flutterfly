import 'package:flutter/material.dart';

MaterialApp materialApp(final BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutterfly',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: const Center(child: Text('Awesome')),
    );
