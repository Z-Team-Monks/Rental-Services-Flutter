import 'package:dartz/dartz.dart';
import 'package:rental/core/data_provider/floor/appdatabase.dart';
import 'package:rental/core/data_provider/floor/entiites/entities.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/admin/failures/admin_failures.dart';
import 'package:rental/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLocalDataProvider {
  // Database dBInstance = getIt<AppDB>().db;
  final SharedPreferences preferences = getIt<SharedPreferences>();

  Future<Either<AdminFaiulre, Unit>> storeOnSharedPref(
      String key, String value) async {
    try {
      await preferences.setString(key, value);
      return right(unit);
    } catch (e) {
      return left(AdminFaiulre.writeToLocalError());
    }
  }

  Either<AdminFaiulre, String?> readFromSharedPref(String key) {
    try {
      final value = preferences.getString(key);
      return right(value);
    } catch (e) {
      return left(AdminFaiulre.readFromLocalError());
    }
  }

  Future<Either<AdminFaiulre, List<Property>>> getProperties() async {
    var db = await getIt.get<Future<AppDatabase>>();
    try {
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
          ),
        );
      }

      return right(properties);
    } catch (e) {
      return left(AdminFaiulre.readFromLocalError());
    }
  }

  Future<Either<AdminFaiulre, Unit>> cacheProperties({
    required List<Property> properties,
  }) async {
    try {
      var db = await getIt.get<Future<AppDatabase>>();
      List<PropertyEntity> propertyList = [];
      for (var property in properties) {
        propertyList.add(PropertyEntity(
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
        ));
      }
      await db.propertyEntityDao.insertManyProperty(propertyList);

      return right(unit);
    } catch (e) {
      return left(AdminFaiulre.writeToLocalError());
    }
  }

  Future<Either<AdminFaiulre, Unit>> clearCachedProperties() async {
    try {
      var db = await getIt.get<Future<AppDatabase>>();
      await db.propertyEntityDao.deleteAllProperty();

      return right(unit);
    } catch (e) {
      return left(AdminFaiulre.writeToLocalError());
    }
  }
}
