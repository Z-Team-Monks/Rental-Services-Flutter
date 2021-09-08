import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import '../../locator.dart';

class AppDB {
  late final AppDB instance;
  late final Database db;

  Future<AppDB> getInstance(int version) async {
    instance = await getIt.get<Future<AppDB>>();
    await initOrGetDB(version);
    return instance;
  }

  Database get getDb => db;

  Future<void> initOrGetDB(int version) async {
    db = await openDatabase(
      path.join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        /// create [User] table
        db.execute(
          'CREATE TABLE users(id TEXT PRIMARY KEY, name TEXT, email TEXT, profileImage TEXT, isAdmin INTEGER)',
        );

        /// create [Property] table
        db.execute(
          'CREATE TABLE properties(id TEXT PRIMARY KEY, ownerid TEXT , createdAt TEXT, updatedAt TEXT, title TEXT,  description TEXT, category TEXT, bill REAL, per TEXT, status INTEGER, rating REAL )',
        );
      },
      version: version,
    );
  }
}
