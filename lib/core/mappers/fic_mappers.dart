import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

void initializeFICMappers() {
  MapperContainer.globals.useAll([
    // ignore: strict_raw_type
    SerializableMapper<IList, Object>.arg1(
      decode: IList.fromJson,
      encode: (final list) => list.toJson,
      type: <E>(final f) => f<IList<E>>(),
    ),
    // ignore: strict_raw_type
    SerializableMapper<IMap, Map<String, dynamic>>.arg2(
      decode: IMap.fromJson,
      encode: (final map) => map.toJson,
      type: <Key, Val>(final f) => f<IMap<Key, Val>>(),
    ),
  ]);
}
