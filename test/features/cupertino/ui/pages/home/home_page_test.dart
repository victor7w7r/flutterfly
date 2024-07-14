import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/cupertino/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/cupertino/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/theme_toggle.dart';

final class MockCupertinoService extends Mock
    with ChangeNotifier
    implements CupertinoService {}

void main() {
  group('HomePage', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<CupertinoService>(MockCupertinoService());
      GetIt.I.registerSingleton(DataService());

      when(() => GetIt.I<CupertinoService>().isDark).thenReturn(false);
    });

    patrolWidgetTest('render widget successfully', (final $) async {
      GetIt.I<DataService>().mutate = 'Hello, Flutter!';

      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: HomePage()),
        ),
      );

      expect($('Happy Hacking!, Dart... Dart...'), findsOneWidget);
      expect($('Made with love by '), findsOneWidget);

      expect($(ThemeToggle), findsOneWidget);
      expect($(DynamicChip), findsWidgets);
    });

    patrolWidgetTest('render widget successfully with empty state',
        (final $) async {
      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: HomePage()),
        ),
      );

      expect($('Happy Hacking!, Dart... Dart...'), findsOneWidget);
      expect($('Made with love by '), findsOneWidget);
      expect($('Store state: Not yet.'), findsOneWidget);
      expect($(ThemeToggle), findsOneWidget);
      expect($(DynamicChip), findsWidgets);
    });
  });
}
