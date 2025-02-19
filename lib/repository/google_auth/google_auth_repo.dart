// import 'package:firebase_auth/firebase_auth.dart';

// abstract class AuthRepo {
//   Future<User?> authGoogle();

//   Future<void> authSignOut();
// }
import 'package:firebase_auth/firebase_auth.dart';

abstract class GoogleAuthRepo {
  Future<User?> authGoogle();

  Future<void> authSignOut();
}
