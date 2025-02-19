// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:zartek/repository/auth_api/auth_repo.dart';

// import '../../data/firebase_services/firebase_auth.dart';

// class AuthRepoImpl implements AuthRepo {
//   final FirebaseAuthService _authService;

//   AuthRepoImpl(this._authService);

//   @override
//   Future<User?> authGoogle() async {
//     return await _authService.signInWithGoogle();
//   }

//   @override
//   Future<void> authSignOut() async {
//     await _authService.signOut();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek/repository/google_auth/google_auth_repo.dart';

import '../../data/firebase_services/firebase_auth.dart';

class GoogleAuthRepoImpl implements GoogleAuthRepo {
  final FirebaseAuthService _authService;

  GoogleAuthRepoImpl(this._authService);

  @override
  Future<User?> authGoogle() async {
    return await _authService.signInWithGoogle();
  }

  @override
  Future<void> authSignOut() async {
    await _authService.signOut();
  }
}
