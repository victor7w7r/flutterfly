import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart' show Mock, when;
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/title.dart';

class MockPlatform extends Mock implements Platform {}

void main() {
  group('Title', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<Platform>(MockPlatform());
    });

    patrolWidgetTest('Render when platform is macOS', (final $) async {
      final platform = GetIt.I<Platform>();
      when(() => platform.isMacOS).thenReturn(true);
      when(() => platform.isDesktop).thenReturn(false);

      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(
            child: CupTitle(true, child: SizedBox()),
          ),
        ),
      );

      expect($(SizedBox), findsOneWidget);
    });

    patrolWidgetTest('Render when platform is not macOS and is desktop',
        (final $) async {
      final platform = GetIt.I<Platform>();
      when(() => platform.isMacOS).thenReturn(false);
      when(() => platform.isDesktop).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(
            child: CupTitle(true, child: SizedBox()),
          ),
        ),
      );

      expect($(SizedBox), findsOneWidget);
    });

    patrolWidgetTest('Render when platform is not macOS and not desktop',
        (final $) async {
      final platform = GetIt.I<Platform>();
      when(() => platform.isMacOS).thenReturn(false);
      when(() => platform.isDesktop).thenReturn(false);

      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(
            child: CupTitle(true, child: SizedBox()),
          ),
        ),
      );

      expect($('CupertinoApp'), findsOneWidget);
    });
  });
}
