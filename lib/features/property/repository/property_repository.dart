import 'package:image_picker/image_picker.dart';
import 'package:rental/core/data_provider/data_access.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/data_provider/property_local_data_provider.dart';
import 'package:rental/features/property/data_provider/property_remote_data_provider.dart';

class PropertyRepository {
  final PropertyLocalDataProvider _propertyLocalDataProvider;
  final PropertyRemoteDataProvider _propertyRemoteDataProvider;

  PropertyRepository(
    this._propertyLocalDataProvider,
    this._propertyRemoteDataProvider,
  );

  PropertyLocalDataProvider get propertyLocalDataProvide =>
      this._propertyLocalDataProvider;

  PropertyRemoteDataProvider get propertyRemoteDataProvider =>
      this._propertyRemoteDataProvider;

  Future<List<Property>?> getPropertiesFromLocalOrRemote() =>
      performRemoteOrLocalFetchOperation<List<Property>>(apiCall: () async {
        return await propertyRemoteDataProvider.getProperties();
      }, dbCall: () async {
        return await propertyLocalDataProvide.getProperties();
      });

  Future<List<Property>?> getPropertiesFromRemote() =>
      propertyRemoteDataProvider.getProperties();

  Future<List<Property>?> getPropertiesFromLocal() =>
      propertyLocalDataProvide.getProperties();

  Future<Property?> getPropertyFromLocalOrRemote(String id) =>
      performRemoteOrLocalFetchOperation<Property>(
        apiCall: () async {
          return await propertyRemoteDataProvider.getProperty(id);
        },
        dbCall: () async {
          return await propertyLocalDataProvide.getProperty(
            propertyId: id,
          );
        },
      );

  Future<Property> getPropertyFromRemote(String id) =>
      propertyRemoteDataProvider.getProperty(id);

  Future<Property?> getPropertyFromLocal(String id) =>
      propertyLocalDataProvide.getProperty(
        propertyId: id,
      );

  // Future<Property?> createAndStoreProperty(Property property) {
  //   return performRemoteAndLocalSaveOperation<Property>(
  //     apiCall: () async {
  //       return await propertyRemoteDataProvider.createProperty(
  //         property: property,
  //         token: "the_token_from_logedin_user!",
  //       );
  //     },
  //     dbCall: (Property? data) async {
  //       await propertyLocalDataProvide.storeProperty(property: data!);
  //     },
  //   );
  // }

  // Future<Property> createRemoteProperty(Property property) =>
  //     propertyRemoteDataProvider.createProperty(
  //       property: property,
  //       token: "the_token_of_the_logedin_user!",
  //     );

  Future<Property> createLocalProperty(Property property) =>
      propertyLocalDataProvide.storeProperty(
        property: property,
      );

  Future<void> addProduct(
      {required Property property, required List<XFile> images}) async {
    // await Future.delayed(Duration(seconds: 1));
    // print(property);

    final newProduct = await _propertyRemoteDataProvider.createProperty(
        property: property, t: "", images: images);

    // return newProduct;
  }

  Future<Property> getDetailedProduct(String id) async {
    final product = await _propertyRemoteDataProvider.loadProperty(id: id);
    return product;
  }

  Future<Property> updateProdcut(Property property) async {
    final updaetdProduct = await _propertyRemoteDataProvider.editProperty(
        property: property, token: "");
    return updaetdProduct;
  }
}
