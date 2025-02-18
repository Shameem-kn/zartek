import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<User?> authGoogle();
  Future<void> authSignOut();
}
