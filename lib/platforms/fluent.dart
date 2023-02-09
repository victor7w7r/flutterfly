import 'package:fluent_ui/fluent_ui.dart';

FluentApp fluentApp(BuildContext context) {
  return const FluentApp(
    debugShowCheckedModeBanner: false,
    title: 'flutterfly',
    home: Center(
      child: Text('Awesome', style: TextStyle(color: Colors.white))
    )
  );
}