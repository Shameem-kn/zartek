import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneAuthRepo {
  Future<void> signInWithPhone(
      String phoneNumber, Function(String) codeSentCallback);
  Future<User?> verifyOTP(String verificationId, String otp);
  Future<void> signOut();
}
