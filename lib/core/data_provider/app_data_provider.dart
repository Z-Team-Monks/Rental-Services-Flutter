// import 'dart:io';
// import 'data_providers/providers.dart';

// class AppDataProviderSingleton {
//   late final RemoteDataProvider _rentalRemoteDataProvider;
//   late final LocalDataProvider _localDataProvider;

//   AppDataProviderSingleton() {
//     _rentalRemoteDataProvider = RemoteDataProvider();
//     _localDataProvider = LocalDataProvider(1);
//   }

//   Future<BaseDataProvider> getDataProvider() async {
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         print('connected');
//         return rentalRemoteProvider;
//       }
//     } on SocketException catch (_) {
//       print('not connected');
//     }
//     return localDataProvider;
//   }

//   RemoteDataProvider get rentalRemoteProvider {
//     return this._rentalRemoteDataProvider;
//   }

//   LocalDataProvider get localDataProvider {
//     return this._localDataProvider;
//   }
// }
