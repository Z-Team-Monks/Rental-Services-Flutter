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

}
