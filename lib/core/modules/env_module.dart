import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/env/env.dart';

part 'env_module.g.dart';

enum Mode { dev, prod }

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

@Riverpod(keepAlive: true)
EnvModule envModule(
  final EnvModuleRef ref
) => EnvModule();

@riverpod
Mode modeProvider(
  final ModeProviderRef ref
) => ref.watch(envModule$).mode;

EnvModule envRef<T extends Ref>(
  final T ref
) => ref.read(envModule$);