import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_provider.g.dart';

@riverpod
class DataProvider extends _$DataProvider {

  @override
  String build() => '';

  set mutate(final String state) =>
    this.state = state;

}
