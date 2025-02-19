// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:zartek/core/routes/route_paths.dart';
// import 'package:zartek/view/otp_screen/widget/pinput.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});

//   @override
//   State<OtpScreen> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<OtpScreen> {
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController pinController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomPinput(),
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: double.infinity, // Full width
//                 height: 50, // Fixed height
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(
//                         255, 25, 96, 26), // Dark Green Color
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   onPressed: () {
//                     // After OTP verification, navigate to the UserHomeScreen
//                     Navigator.pushNamed(context, RoutePaths.userHome);
//                   },
//                   child: Text(
//                     "Verify OTP",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 21,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/bloc/bloc/phone_auth_bloc.dart';
import 'package:zartek/bloc/bloc/phone_auth_event.dart';

import 'package:zartek/core/routes/route_paths.dart';
import 'package:zartek/view/otp_screen/widget/pinput.dart';

import '../../bloc/bloc/phone_auth_state.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final phoneAuthBloc = context.read<PhoneAuthBloc>(); // Access BLoC instance

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPinput(pinController: pinController),
              const SizedBox(height: 20),
              BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
                listener: (context, state) {
                  if (state is PhoneAuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutePaths.userHome,
                      (route) => false,
                    );
                  } else if (state is PhoneAuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF19601A), // Dark Green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: state is PhoneAuthLoading
                          ? null // Disable button while loading
                          : () {
                              String otp = pinController.text.trim();
                              if (otp.isNotEmpty) {
                                phoneAuthBloc.add(
                                    VerifyOtpEvent(widget.verificationId, otp));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter the OTP'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                      child: state is PhoneAuthLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Verify OTP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
