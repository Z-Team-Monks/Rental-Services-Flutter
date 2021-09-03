import 'package:rental/core/data_provider/db.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/locator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class PropertyLocalDataProvider {
  late final Database dBInstance = getIt<AppDB>().dBInstance;

  final String baseUrl = "http://10.6.193.148:5000/api";

  /// Store a property in local storage
  ///
  /// accepts a [Property] objects and does not return anything
  ///
  Future<void> storeProperty({
    required Property property,
  }) async {
    var map = property.toMap();
    await dBInstance.insert(
      "users",
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get a Property from localstorage
  ///
  /// returns a [Property] object that has the give userId
  ///
  Future<Property> getProperty({
    required String propertyId,
  }) async {
    var snapshot = await dBInstance.query(
      "users",
      where: "id = ?",
      whereArgs: [
        propertyId,
      ],
      limit: 1,
    );

    return Property.fromJson(snapshot[0]);
  }

  /// Get all properties from localstorage
  ///
  /// returns a [List<Property>] object that has the give userId
  ///
  Future<List<Property>> getProperties({
    required String propertyId,
  }) async {
    var snapshot = await dBInstance.query(
      "users",
      where: "id = ?",
      whereArgs: [
        propertyId,
      ],
    );
    List<Property> properties = [];
    for (var i = 0; i < snapshot.length; i++) {
      properties.add(
        Property.fromJson(
          snapshot[i],
        ),
      );
    }
    return properties;
  }

  /// Get properties with a specific limit from localstorage
  ///
  /// returns a [List<Property>] object that has the give userId
  ///
  Future<List<Property>> getLimitedProperties({
    required String propertyId,
    required int limit,
  }) async {
    var snapshot = await dBInstance.query(
      "users",
      where: "id = ?",
      whereArgs: [
        propertyId,
      ],
      limit: limit,
    );
    List<Property> properties = [];
    for (var i = 0; i < snapshot.length; i++) {
      properties.add(
        Property.fromJson(
          snapshot[i],
        ),
      );
    }
    return properties;
  }

}
