import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repo_impl/user_pref_repo.dart';
import 'phone_auth_event.dart';
import 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final FirebaseAuth _auth;
  final UserPrefRepo _userPrefRepo;

  PhoneAuthBloc(this._userPrefRepo)
      : _auth = FirebaseAuth.instance,
        super(PhoneAuthInitial()) {
    on<PhoneAuthSignInEvent>(_onPhoneAuthSignIn);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  /// Handles phone number authentication
  Future<void> _onPhoneAuthSignIn(
      PhoneAuthSignInEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());

    try {
      final controller = StreamController<String>();

      await _auth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            UserCredential userCredential =
                await _auth.signInWithCredential(credential);
            User? user = userCredential.user;
            if (user != null) {
              await _userPrefRepo.saveUserData(
                  user.phoneNumber ?? "Unknown", user.uid, user.photoURL ?? "");
              emit(PhoneAuthSuccess(user));
            }
          } catch (e) {
            emit(PhoneAuthFailure("Auto-verification failed"));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(PhoneAuthFailure(e.message ?? "Verification failed"));
        },
        codeSent: (String verificationId, int? resendToken) async {
          // await Future.delayed(
          //     const Duration(seconds: 5)); // Wait for 5 seconds
          controller.add(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Auto-retrieval timeout, Verification ID: $verificationId");
        },
      );

      await emit.forEach(
        controller.stream,
        onData: (verificationId) => OtpSentSuccess(verificationId),
      );

      await controller.close();
    } catch (e) {
      emit(PhoneAuthFailure("Something went wrong. Please try again."));
    }
  }

  /// Handles OTP verification
  Future<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otp,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        await _userPrefRepo.saveUserData(
            user.phoneNumber ?? "Unknown", user.uid, user.photoURL ?? "");
        emit(PhoneAuthSuccess(user));
      } else {
        emit(PhoneAuthFailure("OTP verification failed"));
      }
    } catch (e) {
      emit(PhoneAuthFailure("Invalid OTP. Please try again."));
    }
  }
}
