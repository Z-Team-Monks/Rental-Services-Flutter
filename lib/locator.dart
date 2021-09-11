import 'package:get_it/get_it.dart';
import 'package:rental/core/data_provider/db.dart';
import 'package:rental/core/data_provider/floor/appdatabase.dart';
import 'package:rental/features/admin/data_provider/local_data_provider.dart';
import 'package:rental/features/admin/data_provider/remote_data_provider.dart';
import 'package:rental/features/admin/repository/admin_repository.dart';
import 'package:rental/features/auth/repository/repository.dart';
import 'package:rental/features/auth/data_provider/local_provider.dart';
import 'package:rental/features/auth/data_provider/remote_provider.dart';
import 'package:rental/features/property/data_provider/property_local_data_provider.dart';
import 'package:rental/features/property/data_provider/property_remote_data_provider.dart';
import 'package:rental/features/property/repository/property_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUp() async {
  getIt.registerLazySingleton<PropertyRepository>(() => PropertyRepository(
        PropertyLocalDataProvider(),
        PropertyRemoteDataProvider(),
      ));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(
        AuthLocalDataProvider(),
        AuthRemoteDataProvider(),
      ));

  getIt.registerLazySingleton<AdminRepository>(() => AdminRepository(
        AdminLocalDataProvider(),
        AdminRemoteDataProvider(),
      ));

  getIt.registerLazySingleton<Future<AppDatabase>>(
      () async => await $FloorAppDatabase.databaseBuilder("app.db").build());

  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  // getIt.registerSingletonAsync<Telephony>(() async => Telephony.instance);
}
