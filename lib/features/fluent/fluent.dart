import 'package:fluent_ui/fluent_ui.dart';

import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/features/fluent/data/providers/fluent_provider.dart';
import 'package:flutterfly/features/fluent/presentation/views/home/home.dart';
import 'package:flutterfly/features/fluent/presentation/views/store/store.dart';

class FluentModule extends StatelessWidget {

  const FluentModule({super.key});

  @override
  Widget build(context) => FluentApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (_) => const Home(),
      '/store': (_) => const Store()
    },
    color: context.watch(fluentProvider)
      .themeColor[0]
  );
}