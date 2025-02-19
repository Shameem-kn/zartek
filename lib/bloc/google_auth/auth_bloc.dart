// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:zartek/bloc/google_auth/auth_event.dart';
// import 'package:zartek/bloc/google_auth/auth_state.dart';
// import 'package:zartek/repository/google_auth/google_auth_repo.dart';
// import 'package:zartek/repository/user_pref/user_pref_repo.dart';

// class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
//   final GoogleAuthRepo _authRepo;
//   final UserPrefRepo _userPrefRepo;

//   // Constructor with injected dependencies
//   // GoogleAuthBloc(
//   //   this._authRepo,
//   //   this._userPrefRepo,
//   // ) : super(GoogleAuthInitialState()) {
//   //   on<GoogleSignInRequested>(_onGoogleSignIn);
//   //   on<GoogleSignOutRequested>(_onGoogleSignOut);
//   // }
//   GoogleAuthBloc(
//       {required GoogleAuthRepo authRepo, required UserPrefRepo userPrefRepo})
//       : _authRepo = authRepo,
//         _userPrefRepo = userPrefRepo,
//         super(GoogleAuthInitialState()) {
//     on<GoogleSignInRequested>(_onGoogleSignIn);
//     on<GoogleSignOutRequested>(_onGoogleSignOut);
//   }

//   // Handles Google Sign-In request
//   Future<void> _onGoogleSignIn(
//       GoogleSignInRequested event, Emitter<GoogleAuthState> emit) async {
//     print("Google Sign-In triggered");
//     emit(GoogleAuthLoadingState());

//     try {
//       final User? user = await _authRepo.authGoogle();
//       if (user != null) {
//         // Safely handle null values for displayName and photoURL
//         final username = user.displayName ?? 'Unknown User';
//         final imageUrl = user.photoURL ?? '';

//         // Save user data to preferences
//         await _userPrefRepo.saveUserData(username, user.uid, imageUrl);

//         emit(GoogleAuthSuccessState(user));
//         print("User signed in: $username");
//       } else {
//         emit(GoogleAuthFailedState("Google Sign-In failed."));
//       }
//     } catch (e) {
//       emit(GoogleAuthFailedState("Error: ${e.toString()}"));
//     }
//   }

//   // Handles Google Sign-Out request
//   Future<void> _onGoogleSignOut(
//       GoogleSignOutRequested event, Emitter<GoogleAuthState> emit) async {
//     emit(GoogleAuthLoadingState());

//     try {
//       await _authRepo.authSignOut();
//       emit(GoogleAuthInitialState());
//     } catch (e) {
//       emit(GoogleAuthFailedState("Sign-Out Failed: ${e.toString()}"));
//     }
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek/bloc/google_auth/auth_event.dart';
import 'package:zartek/bloc/google_auth/auth_state.dart';
import 'package:zartek/repository/google_auth/google_auth_repo.dart';
import 'package:zartek/repository/user_pref/user_pref_repo.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  final GoogleAuthRepo _authRepo;
  final UserPrefRepo _userPrefRepo;

  GoogleAuthBloc({
    required GoogleAuthRepo authRepo,
    required UserPrefRepo userPrefRepo,
  })  : _authRepo = authRepo,
        _userPrefRepo = userPrefRepo,
        super(GoogleAuthInitialState()) {
    on<GoogleSignInRequested>(_onGoogleSignIn);
    on<GoogleSignOutRequested>(_onGoogleSignOut);
  }

  // Handles Google Sign-In request
  Future<void> _onGoogleSignIn(
      GoogleSignInRequested event, Emitter<GoogleAuthState> emit) async {
    print("Google Sign-In triggered");
    emit(GoogleAuthLoadingState());

    try {
      final User? user = await _authRepo.authGoogle();
      if (user != null) {
        final username = user.displayName ?? 'Unknown User';
        final imageUrl = user.photoURL ?? '';

        // Save user data to preferences
        await _userPrefRepo.saveUserData(username, user.uid, imageUrl);

        emit(GoogleAuthSuccessState(user));
        print("User signed in: $username");
      } else {
        emit(GoogleAuthFailedState("Google Sign-In failed."));
      }
    } catch (e) {
      emit(GoogleAuthFailedState("Error: ${e.toString()}"));
    }
  }

  // Handles Google Sign-Out request
  Future<void> _onGoogleSignOut(
      GoogleSignOutRequested event, Emitter<GoogleAuthState> emit) async {
    emit(GoogleAuthLoadingState());

    try {
      await _authRepo.authSignOut();
      emit(GoogleAuthSignOutSuccessState());

      // Delete user data only if sign-out succeeds
      await _userPrefRepo.deleteUserData();
    } catch (e) {
      emit(GoogleAuthFailedState("Sign-Out Failed: ${e.toString()}"));
    }
  }
}
