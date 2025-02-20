import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek/domain/repo_impl/google_auth_repo.dart';

import '../../firebase_services/firebase_auth.dart';

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
