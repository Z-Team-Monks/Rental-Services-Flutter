import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/data_provider/property_remote_data_provider.dart';

class TopRatedRepository {
  final PropertyRemoteDataProvider _propertyRemoteDataProvider;
  TopRatedRepository(this._propertyRemoteDataProvider);
  Future<List<Property>> getTopRatedProperties() => this._propertyRemoteDataProvider.getTopRatedProperties();

}