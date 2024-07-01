import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/title.dart';

class MockPlatform extends Mock implements Platform {}

void main() {
  group('Title', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<Platform>(MockPlatform());
    });

    testWidgets('Render when platform is macOS', (final tester) async {
      final platform = GetIt.I.get<Platform>();
      when(platform.isMacOS).thenReturn(true);
      when(platform.isDesktop).thenReturn(false);

      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(
            child: CupTitle(true, child: SizedBox()),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('Render when platform is not macOS and is desktop',
        (final tester) async {
      final platform = GetIt.I.get<Platform>();
      when(platform.isMacOS).thenReturn(false);
      when(platform.isDesktop).thenReturn(true);

      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(
            child: CupTitle(true, child: SizedBox()),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('Render when platform is not macOS and not desktop',
        (final tester) async {
      final platform = GetIt.I.get<Platform>();
      when(platform.isMacOS).thenReturn(false);
      when(platform.isDesktop).thenReturn(false);

      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(
            child: CupTitle(true, child: SizedBox()),
          ),
        ),
      );

      expect(find.text('CupertinoApp'), findsOneWidget);
    });
  });
}
