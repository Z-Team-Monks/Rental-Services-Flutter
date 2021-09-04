import 'package:floor/floor.dart';
import 'package:rental/core/data_provider/floor/dao/user_dao.dart';
import 'package:rental/core/data_provider/floor/entiites/user.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'appdatabase.g.dart';

@Database(version: 1, entities: [
  Person
  // Register your entities in here,
])
abstract class AppDatabase extends FloorDatabase {
  // register your daos in here;
  PersonDao get personDao;
}
