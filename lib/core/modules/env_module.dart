import 'package:injectable/injectable.dart' show singleton;

import 'package:flutterfly/config/env/env.dart';

enum Mode { dev, prod }

@singleton
final class EnvModule {

  final Mode mode;
  final String host;
  final String protocol;

  EnvModule():
    mode = Mode.values.firstWhere((mode) =>
      mode.toString() == 'Mode.${env['mode'] ?? 'dev'}'
    ),
    host = env['host'] ?? '',
    protocol = env['protocol'] ?? '';

}