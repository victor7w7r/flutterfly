import 'package:fl_query/fl_query.dart' show QueryClientProvider;
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/features/fluent/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/fluent/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';

final class FluentLayout extends StatelessWidget {
  const FluentLayout({super.key, this.child});

  final Widget? child;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<FluentService>(
        builder: (final ctl) => QueryClientProvider(
          child: FluentApp(
            title: 'flutterfly',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (final _) => HomePage(child: child),
              '/store': (final _) => StorePage(child: child),
            },
            color: ctl.state().themeColor.first,
          ),
        ),
      );
}
