import 'package:rental/core/data_provider/db.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/locator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class UserLocalDataProvider {
  // final Database dBInstance = getIt<AppDB>().dBInstance;

  // // UserLocalDataProvider({
  // // required this.dBInstance,
  // // required int version,
  // // }) {
  // // initOrGetDB(version);
  // // }

  // /// Store a user in local storage
  // ///
  // /// accepts a [User] objects and does not return anything
  // ///
  // Future<void> storeUser({
  //   required User user,
  // }) async {
  //   var map = user.toJson();
  //   await dBInstance.insert(
  //     "users",
  //     map,
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // /// Get a user from localstorage
  // ///
  // /// returns a [User] object that has the give userId
  // ///
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

  // /// Get all users from localstorage
  // ///
  // /// returns a [List<User>] object that has the give userId
  // ///
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
}
