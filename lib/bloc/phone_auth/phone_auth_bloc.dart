import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repo_impl/user_pref_repo.dart';
import 'phone_auth_event.dart';
import 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserPrefRepo _userPrefRepo;

  PhoneAuthBloc(this._userPrefRepo) : super(PhoneAuthInitial()) {
    on<PhoneAuthSignInEvent>(_onPhoneAuthSignIn);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  Future<void> _onPhoneAuthSignIn(
      PhoneAuthSignInEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Verification completed automatically.");
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed: ${e.message}");
          if (!emit.isDone) {
            emit(PhoneAuthFailure(e.message ?? "Verification failed"));
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          print("OTP Sent, Verification ID: $verificationId");
          if (!emit.isDone) {
            print("otp sent success event initiated");
            emit(OtpSentSuccess(verificationId));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Auto-retrieval timeout, Verification ID: $verificationId");
        },
      );
    } catch (e) {
      print("Error: $e");
      if (!emit.isDone) {
        emit(PhoneAuthFailure("Something went wrong. Please try again."));
      }
    }
  }

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
        final username = user.phoneNumber ?? 'Unknown User';
        final imageUrl = user.photoURL ?? '';

        await _userPrefRepo.saveUserData(username, user.uid, imageUrl);
        if (!emit.isDone) {
          emit(PhoneAuthSuccess(user));
        }
      } else {
        if (!emit.isDone) {
          emit(PhoneAuthFailure("OTP verification failed"));
        }
      }
    } catch (e) {
      print("Error verifying OTP: $e");
      if (!emit.isDone) {
        emit(PhoneAuthFailure("Invalid OTP. Please try again."));
      }
    }
  }
}
