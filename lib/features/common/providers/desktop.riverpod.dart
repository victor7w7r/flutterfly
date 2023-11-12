import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'desktop.riverpod.g.dart';

@riverpod
final class DesktopProvider extends _$DesktopProvider {
  @override
  String build() => 'none';

  set mutate(final String state) => this.state = state;
}
