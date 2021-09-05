import 'package:get_it/get_it.dart';
import 'package:rental/core/data_provider/db.dart';
import 'package:rental/core/data_provider/floor/appdatabase.dart';
import 'package:rental/features/property/data_provider/property_local_data_provider.dart';
import 'package:rental/features/property/data_provider/property_remote_data_provider.dart';
import 'package:rental/features/property/repository/property_repository.dart';

final GetIt getIt = GetIt.instance;

void setUp() async {
  getIt.registerLazySingleton<AppDB>(() => AppDB(1));
  getIt.registerLazySingleton<PropertyRepository>(() => PropertyRepository(
        PropertyLocalDataProvider(),
        PropertyRemoteDataProvider(),
      ));
  getIt.registerLazySingleton<Future<AppDatabase>>(
      () async => await $FloorAppDatabase.databaseBuilder("app.db").build());
}
