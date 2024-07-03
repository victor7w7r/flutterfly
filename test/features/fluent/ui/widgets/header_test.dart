// ignore_for_file: avoid_empty_blocks

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import 'package:flutterfly/features/fluent/ui/widgets/header.dart';

class MockFluentService extends Mock implements FluentService {}

void main() {
  group('Header', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<FluentService>(MockFluentService());

      final srv = GetIt.I.get<FluentService>();
      when(srv.state).thenReturn(FluentThemeApp.dark());
    });

    testWidgets('Render widget successfully', (final tester) async {
      await tester.pumpWidget(const FluentApp(home: Header()));
      expect(find.byType(Header), findsOneWidget);
    });

    testWidgets('Card widget should have correct background color',
        (final tester) async {
      final srv = GetIt.I.get<FluentService>();

      await tester.pumpWidget(const FluentApp(home: Header()));
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.backgroundColor, srv.state().themeColor[1]);
    });

    testWidgets('FractionallySizedBox should have correct widthFactor',
        (final tester) async {
      await tester.pumpWidget(const FluentApp(home: Header()));
      final box = tester
          .widget<FractionallySizedBox>(find.byType(FractionallySizedBox));
      expect(box.widthFactor, 0.98);
    });

    testWidgets('ToggleSwitch should toggle dark mode', (final tester) async {
      await tester.runAsync(() async {
        final srv = GetIt.I.get<FluentService>();

        when(() => srv.toggle(false)).thenAnswer((final _) async {});

        await tester.pumpWidget(const FluentApp(home: Header()));
        await tester.tap(find.byType(ToggleSwitch));
        await tester.pump();

        verify(() => srv.toggle(false)).called(1);
      });
    });

    testWidgets(
        'Should display Flutter logo and "Flutter Template" '
        'text with correct styling', (final tester) async {
      await tester.pumpWidget(const FluentApp(home: Header()));
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Flutter Template'), findsOneWidget);
    });
  });
}
