import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import 'package:flutterfly/features/fluent/ui/widgets/header.dart';

final class MockFluentService extends Mock implements FluentService {}

void main() {
  group('Header', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<FluentService>(MockFluentService());

      when(() => GetIt.I<FluentService>().state)
          .thenReturn(FluentThemeApp.dark());
    });

    patrolWidgetTest('render widget successfully', (final $) async {
      await $.pumpWidgetAndSettle(const FluentApp(home: Header()));
      expect($(Header), findsOneWidget);
    });

    patrolWidgetTest('card widget should have correct background color',
        (final $) async {
      await $.pumpWidgetAndSettle(const FluentApp(home: Header()));
      expect(
        $.tester.widget<Card>($(Card)).backgroundColor,
        GetIt.I<FluentService>().state.themeColor[1],
      );
    });

    patrolWidgetTest('fractionallySizedBox should have correct widthFactor',
        (final $) async {
      await $.pumpWidgetAndSettle(const FluentApp(home: Header()));
      final box =
          $.tester.widget<FractionallySizedBox>($(FractionallySizedBox));
      expect(box.widthFactor, 0.98);
    });

    patrolWidgetTest('toggleSwitch should toggle dark mode', (final $) async {
      final srv = GetIt.I<FluentService>();

      when(() => srv.toggle(false)).thenAnswer((final _) async {});

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const FluentApp(home: Header()));
        await $(ToggleSwitch).tap();
        await $.pump();

        verify(() => srv.toggle(false)).called(1);
      });
    });

    patrolWidgetTest(
        'should display Flutter logo and "Flutter Template" '
        'text with correct styling', (final $) async {
      await $.pumpWidgetAndSettle(const FluentApp(home: Header()));
      expect($(Image), findsOneWidget);
      expect($('Flutter Template'), findsOneWidget);
    });
  });
}
