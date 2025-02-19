// import 'package:equatable/equatable.dart';

// abstract class PhoneAuthEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// /// Send OTP event
// class SendOtpEvent extends PhoneAuthEvent {
//   final String phoneNumber;

//   SendOtpEvent(this.phoneNumber);

//   @override
//   List<Object?> get props => [phoneNumber];
// }

// /// Verify OTP event
// class VerifyOtpEvent extends PhoneAuthEvent {
//   final String verificationId;
//   final String otp;

//   VerifyOtpEvent(this.verificationId, this.otp);

//   @override
//   List<Object?> get props => [verificationId, otp];
// }

// /// Sign out event
// class PhoneAuthSignOutEvent extends PhoneAuthEvent {}
import 'package:equatable/equatable.dart';

abstract class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to sign in with phone number (send OTP)
class PhoneAuthSignInEvent extends PhoneAuthEvent {
  final String phoneNumber;

  const PhoneAuthSignInEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

/// Event to verify OTP
class VerifyOtpEvent extends PhoneAuthEvent {
  final String verificationId;
  final String otp;

  const VerifyOtpEvent(this.verificationId, this.otp);

  @override
  List<Object?> get props => [verificationId, otp];
}

/// Event to sign out
class PhoneAuthSignOutEvent extends PhoneAuthEvent {
  const PhoneAuthSignOutEvent();
}
