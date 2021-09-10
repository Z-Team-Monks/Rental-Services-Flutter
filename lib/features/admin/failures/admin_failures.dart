import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_failures.freezed.dart';

@freezed
abstract class AdminFaiulre with _$AdminFaiulre {
  const factory AdminFaiulre.serverError() = ServerError;
  const factory AdminFaiulre.networkError() = NetworkFailedError;

  const factory AdminFaiulre.writeToLocalError() = WriteToLocalError;
  const factory AdminFaiulre.readFromLocalError() = ReadFromLocalError;

  const factory AdminFaiulre.invalidValue() = InvalidValue;
  const factory AdminFaiulre.unAuthorized() = UnAuthorized;
}
