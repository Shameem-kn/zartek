// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:zartek/repository/phone_auth/phone_auth_repo.dart';
// import 'phone_auth_event.dart';
// import 'phone_auth_state.dart';

// class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
//   final PhoneAuthRepo _phoneAuthRepo;

//   PhoneAuthBloc(this._phoneAuthRepo) : super(PhoneAuthInitial()) {
//     on<PhoneAuthSignInEvent>(_onPhoneAuthSignIn);
//     on<VerifyOtpEvent>(_onVerifyOtp);
//     on<PhoneAuthSignOutEvent>(_onSignOut);
//   }

//   /// Handles phone authentication (sending OTP)
//   Future<void> _onPhoneAuthSignIn(
//       PhoneAuthSignInEvent event, Emitter<PhoneAuthState> emit) async {
//     emit(PhoneAuthLoading());

//     try {
//       await _phoneAuthRepo.signInWithPhone(event.phoneNumber, (verificationId) {
//         emit(OtpSentSuccess(verificationId));
//       });
//     } catch (e) {
//       emit(PhoneAuthFailure(e.toString()));
//     }
//   }

//   /// Handles OTP verification
//   Future<void> _onVerifyOtp(
//       VerifyOtpEvent event, Emitter<PhoneAuthState> emit) async {
//     emit(PhoneAuthLoading());

//     try {
//       User? user =
//           await _phoneAuthRepo.verifyOTP(event.verificationId, event.otp);
//       if (user != null) {
//         emit(PhoneAuthSuccess(user));
//       } else {
//         emit(PhoneAuthFailure("OTP verification failed"));
//       }
//     } catch (e) {
//       emit(PhoneAuthFailure(e.toString()));
//     }
//   }

//   /// Handles signing out
//   Future<void> _onSignOut(
//       PhoneAuthSignOutEvent event, Emitter<PhoneAuthState> emit) async {
//     emit(PhoneAuthLoading());

//     try {
//       await _phoneAuthRepo.signOut();
//       emit(PhoneAuthSignOutSuccess());
//     } catch (e) {
//       emit(PhoneAuthFailure("Sign out failed: $e"));
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek/repository/phone_auth/phone_auth_repo.dart';
import 'package:zartek/repository/user_pref/user_pref_repo.dart';
import 'phone_auth_event.dart';
import 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final PhoneAuthRepo _phoneAuthRepo;
  final UserPrefRepo _userPrefRepo;

  PhoneAuthBloc({
    required PhoneAuthRepo phoneAuthRepo,
    required UserPrefRepo userPrefRepo,
  })  : _phoneAuthRepo = phoneAuthRepo,
        _userPrefRepo = userPrefRepo,
        super(PhoneAuthInitial()) {
    on<PhoneAuthSignInEvent>(_onPhoneAuthSignIn);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<PhoneAuthSignOutEvent>(_onSignOut);
  }

  /// Handles phone authentication (sending OTP)
  Future<void> _onPhoneAuthSignIn(
      PhoneAuthSignInEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());

    try {
      await _phoneAuthRepo.signInWithPhone(event.phoneNumber, (verificationId) {
        emit(OtpSentSuccess(verificationId));
      });
    } catch (e) {
      emit(PhoneAuthFailure(e.toString()));
    }
  }

  /// Handles OTP verification and saves user data
  Future<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());

    try {
      User? user =
          await _phoneAuthRepo.verifyOTP(event.verificationId, event.otp);
      if (user != null) {
        // Save user data to local storage
        final username = user.displayName ?? 'Unknown User';
        final imageUrl = user.photoURL ?? '';

        // Save user data to preferences
        await _userPrefRepo.saveUserData(username, user.uid, imageUrl);

        emit(PhoneAuthSuccess(user));
      } else {
        emit(PhoneAuthFailure("OTP verification failed"));
      }
    } catch (e) {
      emit(PhoneAuthFailure(e.toString()));
    }
  }

  /// Handles signing out
  Future<void> _onSignOut(
      PhoneAuthSignOutEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());

    try {
      await _phoneAuthRepo.signOut();
      emit(PhoneAuthSignOutSuccess());
      await _userPrefRepo.deleteUserData();
      print("data cleared");
    } catch (e) {
      emit(PhoneAuthFailure("Sign out failed: $e"));
    }
  }
}
