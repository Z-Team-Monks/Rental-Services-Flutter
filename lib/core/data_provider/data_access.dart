import 'package:rental/core/exceptions/auth_exception.dart';
import 'package:rental/core/models/entity.dart';

typedef NetworkCall<ResponseHandler> = ResponseHandler Function();
typedef DatabseQuery<ResponseHandler> = ResponseHandler Function(
    EntityModel enitity);

enum Status { notAssigned, success, failure }

enum AuthFailure {
  notAssigned,
  userExists,
  success,
  netowrk,
  passwordTooShort,
  invalidEmailAddress,
  invalidEmailOrPassword
}

class AuthResponseHandler<T> {
  T? data;
  AuthFailure failureOrSuccess = AuthFailure.notAssigned;
  String message = "";
  AuthResponseHandler({
    required this.data,
  });
}

class ResponseHandler<T> {
  T? data;
  Status failureOrSuccess = Status.notAssigned;
  String message = "";
  ResponseHandler({
    required this.data,
  });
}

Future<AuthResponseHandler<T>> performAuthAndSaveOperation<T>({
  required NetworkCall networkCall,
  required DatabseQuery databseQuery,
}) async {
  var response = AuthResponseHandler<T>(
    data: null,
  )..failureOrSuccess = AuthFailure.notAssigned;
  try {
    var data = await networkCall();
    response.data = data;
    response.failureOrSuccess = AuthFailure.success;
    // do the needed storage of token in here
    // await databseQuery();
    databseQuery(data as EntityModel);
    return response;
  } on EmailAlreadyExistsException catch (_) {
    response.failureOrSuccess = AuthFailure.userExists;
    response.message = _.cause;
  } on PasswordLenthTooShort catch (_) {
    response.failureOrSuccess = AuthFailure.passwordTooShort;
    response.message = _.cause;
  } on InvalidEmailAddressException catch (_) {
    response.failureOrSuccess = AuthFailure.invalidEmailAddress;
    response.message = _.cause;
  } on IncorrectEmailOrPasswordException catch (_) {
    response.failureOrSuccess = AuthFailure.invalidEmailOrPassword;
    response.message = _.cause;
  } catch (e) {
    response.message = "Some Error Ocurred";
    response.failureOrSuccess = AuthFailure.netowrk;
  }
  return response;
}

Future<ResponseHandler<T>> performRemoteCallOperation<T>(
    {required NetworkCall networkCall}) async {
  var response = ResponseHandler<T>(data: null)
    ..failureOrSuccess = Status.notAssigned;
  try {
    var data = await networkCall();
    response.failureOrSuccess = Status.success;
    response.data = data;
    return response;
  } catch (e) {
    response.failureOrSuccess = Status.failure;
    response.message = "Some Error Occured";
  }
  return response;
}

Future<ResponseHandler<T>> performAPICallAndSaveOperation<T>({
  required NetworkCall networkCall,
  required DatabseQuery databseQuery,
}) async {
  var response = ResponseHandler<T>(data: null)
    ..failureOrSuccess = Status.notAssigned;
  try {
    var data = await networkCall();
    response.failureOrSuccess = Status.success;
    response.data = data;

    // save to local cache after reciving it from remote
    await databseQuery(data as EntityModel);
    return response;
  } catch (e) {
    response.failureOrSuccess = Status.failure;
    response.message = "Some Error Occured";
  }
  return response;
}

Future<ResponseHandler<T>> performLocalOperation<T>({
  required T? input,
  required DatabseQuery databseQuery,
}) async {
  var response = ResponseHandler<T>(data: null)
    ..failureOrSuccess = Status.notAssigned;
  try {
    var data = await databseQuery(input as EntityModel);
    response.failureOrSuccess = Status.success;
    response.data = data;
    return response;
  } catch (e) {
    response.failureOrSuccess = Status.failure;
    response.message = "Some Error Occured";
  }
  return response;
}
