// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class FirebaseAuthService {
//   final FirebaseAuth _firebaseAuth;
//   final GoogleSignIn _googleSignIn;

//   FirebaseAuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
//       : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
//         _googleSignIn = googleSignIn ?? GoogleSignIn();

//   Future<User?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         print("Google Sign-In was canceled.");
//         throw Exception("Google Sign-In was canceled.");
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       if (googleAuth.idToken == null) {
//         throw Exception("ID Token is null.");
//       }

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final UserCredential userCredential =
//           await _firebaseAuth.signInWithCredential(credential);
//       print("credentials : ${userCredential.user}");
//       return userCredential.user;
//     } catch (e) {
//       print("Error during Google Sign-In: $e");
//       throw Exception(e.toString());
//     }
//   }

//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _firebaseAuth.signOut();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google Sign-In was canceled.");
        throw Exception("Google Sign-In was canceled.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        throw Exception("ID Token is null.");
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      print("Google credentials : ${userCredential.user}");
      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      throw Exception(e.toString());
    }
  }

  /// Sign in with Phone
  Future<void> signInWithPhone(
      String phoneNumber, Function(String) codeSentCallback) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception("Phone verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          codeSentCallback(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("OTP auto-retrieval timed out.");
        },
      );
    } catch (e) {
      print("Error sending OTP: $e");
      throw Exception("Error sending OTP: $e");
    }
  }

  /// Verify OTP and sign in
  Future<User?> verifyOTP(String verificationId, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Invalid OTP or verification failed: $e");
      throw Exception("Invalid OTP or verification failed: $e");
    }
  }

  /// Sign out from both Google and Phone authentication
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
