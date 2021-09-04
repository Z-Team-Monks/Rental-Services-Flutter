// entity/person.dart

import 'package:floor/floor.dart';

@entity
class Person {
  @primaryKey
  final int id;
  // @ignore
  final String name;

  Person(this.id, this.name);
}
