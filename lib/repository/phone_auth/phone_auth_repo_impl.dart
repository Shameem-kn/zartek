import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek/data/firebase_services/firebase_auth.dart';
import 'package:zartek/repository/phone_auth/phone_auth_repo.dart';

class PhoneAuthRepoImpl implements PhoneAuthRepo {
  final FirebaseAuthService _authService;

  PhoneAuthRepoImpl(this._authService);

  @override
  Future<void> signInWithPhone(
      String phoneNumber, Function(String) codeSentCallback) async {
    await _authService.signInWithPhone(phoneNumber, codeSentCallback);
  }

  @override
  Future<User?> verifyOTP(String verificationId, String otp) async {
    return await _authService.verifyOTP(verificationId, otp);
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
  }
}
