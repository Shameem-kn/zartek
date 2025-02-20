import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/routes/route_paths.dart';
import '../../utils/validator.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool isLoading = false;

  void _verifyPhoneNumber() async {
    String phoneNumber = _phoneController.text.trim();

    if (!isValidPhoneNumber(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit phone number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification failed")),
        );
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          isLoading = false;
        });

        Navigator.pushNamed(
          context,
          RoutePaths.otp,
          arguments: verificationId,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // print("Auto-retrieval timeout, Verification ID: $verificationId");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Phone Number'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _verifyPhoneNumber,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Get OTP',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/bloc/phone_auth_bloc.dart';
// import '../../bloc/bloc/phone_auth_event.dart';
// import '../../bloc/bloc/phone_auth_state.dart';
// import '../../core/routes/route_paths.dart';
// import '../../utils/validator.dart';

// class PhoneNumberScreen extends StatefulWidget {
//   const PhoneNumberScreen({super.key});

//   @override
//   _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
// }

// class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
//   final TextEditingController _phoneController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter Phone Number'),
//         backgroundColor: Colors.green,
//       ),
//       body: BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
//         listener: (context, state) {
//           if (state is OtpSentSuccess) {
//             print(
//                 "OTP Sent Successfully. Verification ID: ${state.verificationId}");

//             Navigator.pushNamed(
//               context,
//               RoutePaths.otp,
//               arguments: state.verificationId, // Pass verification ID
//             );
//           } else if (state is PhoneAuthSuccess) {
//             print(
//                 "Phone Authentication Successful. Navigating to next screen...");

//             Navigator.pushReplacementNamed(
//                 context, RoutePaths.otp); // Navigate to the home screen
//           } else if (state is PhoneAuthFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           bool isLoading = state is PhoneAuthLoading;

//           return Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextField(
//                       controller: _phoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration: const InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: isLoading
//                             ? null
//                             : () {
//                                 String phoneNumber =
//                                     _phoneController.text.trim();
//                                 if (phoneNumber.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content:
//                                           Text('Please enter a phone number'),
//                                       backgroundColor: Colors.red,
//                                     ),
//                                   );
//                                 } else if (isValidPhoneNumber(phoneNumber)) {
//                                   context
//                                       .read<PhoneAuthBloc>()
//                                       .add(PhoneAuthSignInEvent(phoneNumber));
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                           'Please enter a valid 10-digit phone number'),
//                                       backgroundColor: Colors.red,
//                                     ),
//                                   );
//                                 }
//                               },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: isLoading
//                             ? const CircularProgressIndicator(
//                                 color: Colors.white)
//                             : const Text(
//                                 'Get OTP',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
