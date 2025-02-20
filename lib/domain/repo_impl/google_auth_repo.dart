import 'package:firebase_auth/firebase_auth.dart';

abstract class GoogleAuthRepo {
  Future<User?> authGoogle();

  Future<void> authSignOut();
}
