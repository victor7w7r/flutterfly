import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../providers/data.riverpod.g.dart';

@riverpod
final class DataProvider extends _$DataProvider {
  @override
  String build() => '';

  set mutate(final String state) => this.state = state;
}
