import 'package:get_it/get_it.dart';
import 'package:rental/core/data_provider/db.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerLazySingleton<AppDB>(() => AppDB(1));
}
