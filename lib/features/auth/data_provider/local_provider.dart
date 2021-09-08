import 'package:dartz/dartz.dart';
import 'package:rental/core/data_provider/db.dart';
import 'package:rental/core/data_provider/floor/appdatabase.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/auth/failures/auth_failure.dart';
import 'package:rental/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class AuthLocalDataProvider {
  // Database dBInstance = getIt<AppDB>().db;
  final SharedPreferences preferences = getIt<SharedPreferences>();

  /// Store a user in local storage
  ///
  /// accepts a [User] objects and does not return anything
  ///
  Future<void> storeUser({
    required User user,
  }) async {
    var dBInstance = await getIt.get<Future<AppDatabase>>();
    var map = user.toJson();
    // await dBInstance.userDao.insertUser(user).insert(
    //   "users",
    //   map,
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }

  /// Get a user from localstorage
  ///
  /// returns a [User] object that has the give userId
  ///
  // Future<User> getUser({
  //   required String userId,
  // }) async {
  //   var snapshot = await dBInstance.query(
  //     "users",
  //     where: "id = ?",
  //     whereArgs: [
  //       userId,
  //     ],
  //     limit: 1,
  //   );

  //   return User.fromJson(snapshot[0]);
  // }

  /// Get all users from localstorage
  ///
  /// returns a [List<User>] object that has the give userId
  ///
  // Future<List<User>> getUsers() async {
  //   var snapshot = await dBInstance.query(
  //     "users",
  //   );

  //   List<User> users = [];

  //   for (var i = 0; i < snapshot.length; i++) {
  //     users.add(
  //       User.fromJson(
  //         snapshot[i],
  //       ),
  //     );
  //   }
  //   return users;
  // }

  Future<Either<AuthFaiulre, Unit>> storeOnSharedPref(
      String key, String value) async {
    try {
      await preferences.setString(key, value);
      return right(unit);
    } catch (e) {
      return left(AuthFaiulre.writeToLocalError());
    }
  }

  Either<AuthFaiulre, String?> readFromSharedPref(String key) {
    try {
      final value = preferences.getString(key);
      return right(value);
    } catch (e) {
      return left(AuthFaiulre.readFromLocalError());
    }
  }
}
