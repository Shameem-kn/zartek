bool isValidPhoneNumber(String phoneNumber) {
  // Regular expression to check if phone number has exactly 10 digits
  final RegExp phoneRegExp = RegExp(r'^\d{10}$');
  return phoneRegExp.hasMatch(phoneNumber);
}
