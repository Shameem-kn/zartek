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
//       print(googleAuth.idToken);
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       print("id is ${credential.providerId}");

//       final UserCredential userCredential =
//           await _firebaseAuth.signInWithCredential(credential);
//       return userCredential.user;
//     } catch (e) {
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
      print("credentials : ${userCredential.user}");
      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
