import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

final class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String> getApplicationDocumentsPath() async =>
      kApplicationDocumentsPath;
  @override
  Future<String> getApplicationSupportPath() async => kApplicationSupportPath;

  @override
  Future<String> getDownloadsPath() async => kDownloadsPath;

  @override
  Future<List<String>> getExternalCachePaths() async =>
      <String>[kExternalCachePath];

  @override
  Future<String> getExternalStoragePath() async => kExternalStoragePath;

  @override
  Future<String> getLibraryPath() async => kLibraryPath;

  @override
  Future<String> getTemporaryPath() async => kTemporaryPath;
}

void disableOverflowErrors() {
  FlutterError.onError = (final details) {
    final exception = details.exception;
    final isOverflowError = exception is FlutterError &&
        !exception.diagnostics.any(
          (final e) =>
              e.value.toString().startsWith('A RenderFlex overflowed by'),
        );

    if (isOverflowError) {
      // ignore: avoid_print
      print('Overflow error.');
    } else {
      FlutterError.presentError(details);
    }
  };
}
