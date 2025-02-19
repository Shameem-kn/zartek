// // part of 'phone_auth_bloc.dart';

// // sealed class PhoneAuthState extends Equatable {
// //   const PhoneAuthState();

// //   @override
// //   List<Object> get props => [];
// // }

// // final class PhoneAuthInitial extends PhoneAuthState {}
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// abstract class PhoneAuthState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// /// Initial state
// class PhoneAuthInitial extends PhoneAuthState {}

// /// Loading state
// class PhoneAuthLoading extends PhoneAuthState {}

// /// OTP sent successfully
// class OtpSentState extends PhoneAuthState {
//   final String verificationId;

//   OtpSentState(this.verificationId);

//   @override
//   List<Object?> get props => [verificationId];
// }

// /// OTP verification successful
// class PhoneAuthSuccess extends PhoneAuthState {
//   final User user;

//   PhoneAuthSuccess(this.user);

//   @override
//   List<Object?> get props => [user];
// }

// /// Error state
// class PhoneAuthFailure extends PhoneAuthState {
//   final String error;

//   PhoneAuthFailure(this.error);

//   @override
//   List<Object?> get props => [error];
// }

// /// Sign out success state
// class PhoneAuthSignOutSuccess extends PhoneAuthState {}
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PhoneAuthInitial extends PhoneAuthState {}

/// Loading state
class PhoneAuthLoading extends PhoneAuthState {}

/// OTP sent successfully (includes verification ID and server ID)
class OtpSentSuccess extends PhoneAuthState {
  final String verificationId;

  const OtpSentSuccess(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

/// OTP verification successful
class PhoneAuthSuccess extends PhoneAuthState {
  final User user;

  const PhoneAuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

/// Error state
class PhoneAuthFailure extends PhoneAuthState {
  final String message;

  const PhoneAuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Sign out success state
class PhoneAuthSignOutSuccess extends PhoneAuthState {
  const PhoneAuthSignOutSuccess();
}
