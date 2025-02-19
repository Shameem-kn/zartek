// // import 'package:firebase_auth/firebase_auth.dart';

// // abstract class GoogleAuthState {}

// // class GoogleAuthInitialState extends GoogleAuthState {}

// // class GoogleAuthLoadingState extends GoogleAuthState {}

// // class GoogleAuthSuccessState extends GoogleAuthState {
// //   final User user;
// //   GoogleAuthSuccessState(this.user);
// // }

// // class GoogleAuthFailedState extends GoogleAuthState {
// //   final String error;
// //   GoogleAuthFailedState(this.error);
// // }
// import 'package:firebase_auth/firebase_auth.dart';

// abstract class GoogleAuthState {}

// class GoogleAuthInitialState extends GoogleAuthState {}

// class GoogleAuthLoadingState extends GoogleAuthState {}

// class GoogleAuthSuccessState extends GoogleAuthState {
//   final User user;
//   GoogleAuthSuccessState(this.user);
// }

// class GoogleAuthFailedState extends GoogleAuthState {
//   final String error;
//   GoogleAuthFailedState(this.error);
// }

// class GoogleAuthSignOutState extends GoogleAuthState {}
import 'package:firebase_auth/firebase_auth.dart';

abstract class GoogleAuthState {}

class GoogleAuthInitialState extends GoogleAuthState {}

class GoogleAuthLoadingState extends GoogleAuthState {}

class GoogleAuthSuccessState extends GoogleAuthState {
  final User user;
  GoogleAuthSuccessState(this.user);
}

class GoogleAuthFailedState extends GoogleAuthState {
  final String error;
  GoogleAuthFailedState(this.error);
}

class GoogleAuthSignOutState extends GoogleAuthState {}

class GoogleAuthSignOutSuccessState extends GoogleAuthState {}
