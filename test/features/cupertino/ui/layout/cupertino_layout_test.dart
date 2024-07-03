import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/cupertino/ui/layout/cupertino_layout.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';

class MockPlatform extends Mock implements Platform {}

class MockCupertinoService extends Mock implements CupertinoService {}

void main() {
  group('Title', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<CupertinoService>(MockCupertinoService());
      GetIt.I.registerSingleton<Platform>(Platform());
    });

    testWidgets('Render widget successfully', (final tester) async {
      await tester.runAsync(() async {
        final service = GetIt.I.get<CupertinoService>();

        when(service.isDark).thenReturn(false);

        await tester.pumpWidget(const CupertinoLayout(child: SizedBox()));

        expect(find.byType(CupertinoApp), findsOneWidget);
        expect(find.byType(CupertinoPageScaffold), findsOneWidget);
        expect(find.byType(CupertinoTabScaffold), findsOneWidget);
        expect(find.byType(SizedBox), findsAtLeastNWidgets(3));

        reset(service);

        when(service.isDark).thenReturn(false);

        await tester.pumpWidget(const CupertinoLayout(child: SizedBox()));

        verify(service.isDark).called(2);
      });
    });
  });
}
