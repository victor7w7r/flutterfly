import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutterfly/features/fluent/presentation/screens/home/home.dart';
import 'package:flutterfly/features/fluent/presentation/screens/store/store.dart';
import 'package:flutterfly/features/fluent/providers/fluent_provider.dart';

final class FluentModule extends ConsumerWidget {

  const FluentModule({super.key});

  @override
  Widget build(
    final BuildContext context,
    final WidgetRef ref
  ) => FluentApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (final _) => const Home(),
      '/store': (final _) => const Store()
    },
    color: ref.watch(fluentProvider$)
      .themeColor[0]
  );
}
