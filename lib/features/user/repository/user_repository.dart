import 'dart:io';

import 'package:rental/core/models/user.dart';
import 'package:rental/features/user/data_providers/user_local_data_provider.dart';
import 'package:rental/features/user/data_providers/user_remote_data_provider.dart';

class UserRepository {
  final UserRemoteDataProvider _userRemoteDataProvider;
  // final UserLocalDataProvider _userLocalDataProvider;

  UserRepository(
    this._userRemoteDataProvider,
    // this._userLocalDataProvider,
  );

  // call the dataproviders using the data access strategey
  Future<User> updateUser({required User user, String? newProfilePath}) async {
    if (newProfilePath != null) {
      // await _userRemoteDataProvider.uploadProfileImage(newProfilePath);
    }
    var updatedUser = await _userRemoteDataProvider.updateUser(user);
    return updatedUser;
  }

  Future<User> getCurrentUser(String token) {
    return _userRemoteDataProvider.currentUser(token: "");
  }
}
