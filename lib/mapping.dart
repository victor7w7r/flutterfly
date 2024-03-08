import 'package:dart_mappable/dart_mappable.dart';

import 'package:equatable/equatable.dart';

part 'mapping.mapper.dart';

class PersonEntity extends Equatable {
  final String name;
  final int age;

  PersonEntity(this.name, {this.age = 18});

  @override
  List<Object?> get props => [name, age];
}

@MappableClass()
class Person extends PersonEntity with PersonMappable {
  Person(super.name, {super.age = 18});
}
