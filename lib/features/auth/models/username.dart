import 'package:formz/formz.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure([String value = '']) : super.pure(value);
  const Username.dirty([String value = '']) : super.dirty(value);

  static final _usernameRegex = RegExp(
    r'^(?=[a-zA-Z_]{4,20}$)(?!.*[_.]{2})[^_.].*[^_.]$',
  );

  @override
  UsernameValidationError? validator(String? value) {
    return _usernameRegex.hasMatch(value ?? '')
        ? null
        : UsernameValidationError.invalid;
  }
}
