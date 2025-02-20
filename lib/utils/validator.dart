bool isValidPhoneNumber(String phoneNumber) {
  // Regular expression to check if phone number starts with +91 and is followed by exactly 10 digits
  final RegExp phoneRegExp = RegExp(r'^\+91\d{10}$');
  return phoneRegExp.hasMatch(phoneNumber);
}
