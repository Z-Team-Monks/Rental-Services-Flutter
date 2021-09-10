import 'package:floor/floor.dart';
import 'package:rental/core/data_provider/floor/dao/daos.dart';
import 'package:rental/core/data_provider/floor/entiites/entities.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'appdatabase.g.dart';

@Database(
  version: 7,
  entities: [
    UserEntity,
    ImageEntity,
    PropertyEntity
    // Register your entities in here,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  // register your daos in here;
  UserEntityDao get userDao;
  ImageEntityDao get imageEntityDao;
  PropertyEntityDao get propertyEntityDao;
}
