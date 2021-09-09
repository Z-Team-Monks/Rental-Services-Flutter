mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 6;

  bool isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool isTextValid(String name) {
    return name.length > 0;
  }

  bool isPhoneNumberValid(String? phoneNumber) {
    return phoneNumber != null &&
        RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phoneNumber);
  }

  bool isPriceValid(String? price) {
    return price != null && _isNumeric(price);
  }

  bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }
}
