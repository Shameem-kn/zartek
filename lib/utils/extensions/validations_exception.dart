extension EmailValidatorExtension on String {
  bool emailValidator() {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(this);
    return emailValid;
  }
}

extension PhoneNumberValidatorExtension on String {
  bool phoneNumberValidator() {
    // Check if the phone number has exactly 10 digits and only numeric characters
    return RegExp(r'^[0-9]{10}$').hasMatch(this);
  }
}
