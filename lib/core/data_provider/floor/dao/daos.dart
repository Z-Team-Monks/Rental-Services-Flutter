// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:rental/core/data_provider/floor/entiites/entities.dart';

@dao
abstract class UserEntityDao {
  @Query('SELECT * FROM users')
  Future<List<UserEntity>> findAllUsers();

  @Query('SELECT * FROM users WHERE id = :id')
  Stream<UserEntity?> findUser(
    String id,
  );

  @insert
  Future<void> insertUser(UserEntity user);
}

@dao
abstract class PropertyEntityDao {
  @Query('SELECT * FROM properties')
  Future<List<PropertyEntity>> fetchAllProperties();

  @Query('SELECT * FROM properties WHERE id = :id')
  Future<PropertyEntity?> findProperty(
    String id,
  );

  @insert
  Future<void> insertProperty(PropertyEntity propertyEntity);

  @insert
  Future<void> insertManyProperty(List<PropertyEntity> propertyEntities);

  @Query('DELETE FROM properties WHERE id = :id')
  Future<void> deleteProperty(String id);

  @Query('DELETE FROM properties')
  Future<void> deleteAllProperty();
}

@dao
abstract class ImageEntityDao {
  @Query('SELECT * FROM images')
  Future<List<ImageEntity>> fetchAllProperties();

  @Query('SELECT * FROM images WHERE id = :id')
  Future<List<ImageEntity>> findImage(
    String id,
  );

  @insert
  Future<void> insertImage(ImageEntity propertyEntity);
}

// this will be added once completed
abstract class ReviewEntityDao {}
