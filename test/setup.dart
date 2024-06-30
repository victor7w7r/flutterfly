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

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String> getTemporaryPath() async => kTemporaryPath;

  @override
  Future<String> getApplicationSupportPath() async => kApplicationSupportPath;

  @override
  Future<String> getLibraryPath() async => kLibraryPath;

  @override
  Future<String> getApplicationDocumentsPath() async =>
      kApplicationDocumentsPath;

  @override
  Future<String> getExternalStoragePath() async => kExternalStoragePath;

  @override
  Future<List<String>> getExternalCachePaths() async =>
      <String>[kExternalCachePath];

  @override
  Future<String> getDownloadsPath() async => kDownloadsPath;
}
