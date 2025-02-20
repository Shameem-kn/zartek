import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class OtpSentSuccess extends PhoneAuthState {
  final String verificationId;

  OtpSentSuccess(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

class PhoneAuthSuccess extends PhoneAuthState {
  final User user;

  PhoneAuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class PhoneAuthFailure extends PhoneAuthState {
  final String message;

  PhoneAuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
