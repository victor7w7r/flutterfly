import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'desktop_provider.g.dart';

@riverpod
class DesktopProvider extends _$DesktopProvider {

  @override
  String build() => 'none';

  void mutate(final String state) =>
    this.state = state;

}