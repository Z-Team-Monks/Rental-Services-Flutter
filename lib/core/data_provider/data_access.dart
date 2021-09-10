import 'dart:io';
import 'package:rental/core/models/property.dart';

typedef ApiCall<T> = Future<T> Function();
typedef DbCall<T> = Future<T> Function(T);

Future<T?> performRemoteOrLocalFetchOperation<T>({
  required ApiCall<T?> apiCall,
  required ApiCall<T?> dbCall,
}) async {
  if (await hasInternetConnection()) {
    try {
      var data = await apiCall();
      return data;
    } catch (e) {
      throw Exception("Ineternet Connection unstable!");
    }
  } else {
    try {
      var data = await dbCall();
      return data;
    } catch (e) {
      throw Exception("Some error occured locally!");
    }
  }
}

Future<T?> performRemoteAndLocalSaveOperation<T>({
  required ApiCall<T?> apiCall,
  required DbCall<T?> dbCall,
}) async {
  if (await hasInternetConnection()) {
    try {
      var data = await apiCall();
      await dbCall(data);
      return data;
    } catch (e) {
      throw Exception("Ineternet Connection unstable!");
    }
  } else {
    throw Exception("Some error occured locally!");
  }
}

Future<bool> hasInternetConnection() async {
  try {
    final response = await InternetAddress.lookup('www.kindacode.com');
    return true;
  } on SocketException catch (e) {
    return false;
  } catch (e) {
    return false;
  }
}
