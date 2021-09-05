import 'package:rental/core/data_provider/floor/appdatabase.dart';
import 'package:rental/core/data_provider/floor/entiites/entities.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/locator.dart';

class PropertyLocalDataProvider {
  /// Store a property in local storage
  ///
  /// accepts a [Property] objects and does not return anything
  ///
  Future<Property> storeProperty({
    required Property property,
  }) async {
    try {
      var db = await getIt.get<Future<AppDatabase>>();
      await db.propertyEntityDao.insertProperty(
        PropertyEntity(
          id: property.id!,
          ownerid: property.ownerid!,
          title: property.title,
          description: property.description,
          category: property.description,
          bill: property.bill,
          per: property.per,
          status: property.status!,
          rating: property.rating!,
          createdAt: property.createdAt!,
          updatedAt: property.updatedAt!,
        ),
      );

      return property;
    } catch (e) {
      throw Exception("Some Exception occured  Local Store Property");
    }
  }

  /// Get a Property from localstorage
  ///
  /// returns a [Property] object that has the give userId
  ///
  Future<List<Property>> getProperties() async {
    var db = await getIt.get<Future<AppDatabase>>();
    var querySet = await db.propertyEntityDao.fetchAllProperties();
    List<Property> properties = [];
    for (var i = 0; i < querySet.length; i++) {
      var imageQuerySet = await db.imageEntityDao.findImage(querySet[i].id);
      List<String> images = [];
      for (var i = 0; i < imageQuerySet.length; i++) {
        images.add(imageQuerySet[i].imageUrl);
      }
      properties.add(
        Property(
          id: querySet[i].id,
          ownerid: querySet[i].ownerid,
          title: querySet[i].title,
          description: querySet[i].description,
          category: querySet[i].description,
          bill: querySet[i].bill,
          per: querySet[i].per,
          status: querySet[i].status,
          rating: querySet[i].rating,
          createdAt: querySet[i].createdAt,
          updatedAt: querySet[i].updatedAt,
          images: images,

          // likedBy:
          // owner:
          // reviewes:
        ),
      );
    }
    return properties;
  }

  /// Get all properties from localstorage
  ///
  /// returns a [List<Property>] object that has the give userId
  ///
  Future<Property?> getProperty({
    required String propertyId,
  }) async {
    var db = await getIt.get<Future<AppDatabase>>();

    var querySet = await db.propertyEntityDao.findProperty(propertyId);
    if (querySet != null) {
      var imageQuerySet = await db.imageEntityDao.findImage(querySet.id);
      List<String> images = [];
      for (var i = 0; i < imageQuerySet.length; i++) {
        images.add(imageQuerySet[i].imageUrl);
      }
      return Property(
        id: querySet.id,
        ownerid: querySet.ownerid,
        title: querySet.title,
        description: querySet.description,
        category: querySet.description,
        bill: querySet.bill,
        per: querySet.per,
        status: querySet.status,
        rating: querySet.rating,
        createdAt: querySet.createdAt,
        updatedAt: querySet.updatedAt,
        images: images,
        // likedBy:
        // owner:
        // reviewes:
      );
    }

    return null;
  }

  // /// Get properties with a specific limit from localstorage
  // ///
  // /// returns a [List<Property>] object that has the give userId
  // ///
  // Future<List<Property>> getLimitedProperties({
  //   required String propertyId,
  //   required int limit,
  // }) async {
  //   var snapshot = await dBInstance.query(
  //     "users",
  //     where: "id = ?",
  //     whereArgs: [
  //       propertyId,
  //     ],
  //     limit: limit,
  //   );
  //   List<Property> properties = [];
  //   for (var i = 0; i < snapshot.length; i++) {
  //     properties.add(
  //       Property.fromJson(
  //         snapshot[i],
  //       ),
  //     );
  //   }
  //   return properties;
  // }
}
