import 'package:equatable/equatable.dart';

abstract class PhoneAuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event to sign in with phone number (send OTP)
class PhoneAuthSignInEvent extends PhoneAuthEvent {
  final String phoneNumber;

  PhoneAuthSignInEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

/// Event to verify OTP
class VerifyOtpEvent extends PhoneAuthEvent {
  final String verificationId;
  final String otp;

  VerifyOtpEvent(this.verificationId, this.otp);

  @override
  List<Object?> get props => [verificationId, otp];
}
