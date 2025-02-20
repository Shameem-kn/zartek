import 'package:equatable/equatable.dart';

abstract class PhoneAuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhoneAuthSignInEvent extends PhoneAuthEvent {
  final String phoneNumber;

  PhoneAuthSignInEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtpEvent extends PhoneAuthEvent {
  final String verificationId;
  final String otp;

  VerifyOtpEvent(this.verificationId, this.otp);

  @override
  List<Object?> get props => [verificationId, otp];
}
