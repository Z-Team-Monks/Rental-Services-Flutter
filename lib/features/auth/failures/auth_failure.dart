import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
abstract class AuthFaiulre with _$AuthFaiulre {
  const factory AuthFaiulre.invalidEmailOrPasssword() = InvalidEmailOrPasssword;
  const factory AuthFaiulre.emailAlreadyInUse() = EmailAlreadyInUse;
}
