import 'package:formz/formz.dart';

enum MessageValidationError { invalid }

class Message extends FormzInput<String, MessageValidationError> {
  const Message.pure([String value = ""]) : super.pure(value);
  const Message.dirty([String value = ""]) : super.dirty(value);

  @override
  MessageValidationError? validator(String? value) {
    return ((value!.length) > 0) ? null : MessageValidationError.invalid;
  }
}
