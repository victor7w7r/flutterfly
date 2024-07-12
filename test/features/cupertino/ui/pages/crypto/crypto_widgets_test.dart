import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/features/cupertino/ui/pages/crypto/crypto_widgets.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';

final class MockCupertinoService extends Mock
    with ChangeNotifier
    implements CupertinoService {}

void main() {
  group('CurrencyCard', () {
    const widget = CupertinoApp(
      home: CupertinoPageScaffold(
        child: CurrencyCard(sym: 'BTC', per: '1.0', pri: '1.0'),
      ),
    );

    setUp(() async {
      await GetIt.I.reset();

      GetIt.I.registerSingleton<CupertinoService>(MockCupertinoService());
      when(() => GetIt.I<CupertinoService>().isDark).thenReturn(false);
    });
    testWidgets('Render widget successfully ', (final tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
      expect(find.text('BTC'), findsOneWidget);
      expect(find.text('1.0%'), findsOneWidget);
      expect(find.text('1.0'), findsOneWidget);

      when(() => GetIt.I<CupertinoService>().isDark).thenReturn(true);

      await tester.pumpWidget(widget);
    });

    testWidgets('Render SizedBox in various context size',
        (final tester) async {
      tester.view.physicalSize = const Size(620, 800);

      await tester.pumpWidget(widget);

      expect(find.byType(SizedBox), findsOneWidget);

      tester.view.physicalSize = const Size(480, 800);

      await tester.pumpWidget(widget);

      expect(find.byType(SizedBox), findsOneWidget);
    });
  });
}
