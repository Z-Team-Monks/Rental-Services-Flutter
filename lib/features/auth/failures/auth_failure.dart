import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
abstract class AuthFaiulre with _$AuthFaiulre {
  const factory AuthFaiulre.serverAuthError() = ServerAuthError;
  const factory AuthFaiulre.invalidEmailOrPasssword() = InvalidEmailOrPasssword;
  const factory AuthFaiulre.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AuthFaiulre.networkError() = NetworkFailedError;

  const factory AuthFaiulre.writeToLocalError() = WriteToLocalError;
  const factory AuthFaiulre.readFromLocalError() = ReadFromLocalError;

  const factory AuthFaiulre.invalidValue() = InvalidValue;
}
