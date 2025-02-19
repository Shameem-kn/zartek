// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/bloc/phone_auth_bloc.dart';
// import '../../bloc/bloc/phone_auth_event.dart';

// import '../../core/routes/route_paths.dart';
// import '../../utils/validator.dart';

// class PhoneNumberScreen extends StatefulWidget {
//   const PhoneNumberScreen({super.key});

//   @override
//   _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
// }

// class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
//   final TextEditingController _phoneController = TextEditingController();

//   void sendOTP(BuildContext context) {
//     String phoneNumber = _phoneController.text.trim();

//     if (isValidPhoneNumber(phoneNumber)) {
//       // Trigger the SendOtpEvent
//       context.read<PhoneAuthBloc>().add(SendOtpEvent(phoneNumber));

//       // Navigate to OTP screen immediately
//       Navigator.pushNamed(
//         context,
//         RoutePaths.otp,
//         arguments: phoneNumber,
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enter a valid 10-digit phone number'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter Phone Number'),
//         backgroundColor: Colors.green,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextField(
//                   controller: _phoneController,
//                   keyboardType: TextInputType.phone,
//                   decoration: const InputDecoration(
//                     labelText: 'Phone Number',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 ElevatedButton(
//                   onPressed: () => sendOTP(context),
//                   child: const Text(
//                     'Get OTP',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     backgroundColor: Colors.green,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/bloc/bloc/phone_auth_event.dart';
import '../../bloc/bloc/phone_auth_bloc.dart';

import '../../bloc/bloc/phone_auth_state.dart';
import '../../core/routes/route_paths.dart';
import '../../utils/validator.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Phone Number'),
        backgroundColor: Colors.green,
      ),
      body: BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
        listener: (context, state) {
          if (state is OtpSentSuccess) {
            // Navigate to OTP screen when OTP is successfully sent
            Navigator.pushNamed(
              context,
              RoutePaths.otp,
            );
          } else if (state is PhoneAuthFailure) {
            // Show error message if OTP sending fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
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
                        onPressed: state is PhoneAuthLoading
                            ? null // Disable button while processing
                            : () {
                                String phoneNumber =
                                    _phoneController.text.trim();
                                if (isValidPhoneNumber(phoneNumber)) {
                                  context
                                      .read<PhoneAuthBloc>()
                                      .add(PhoneAuthSignInEvent(phoneNumber));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please enter a valid 10-digit phone number'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: state is PhoneAuthLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
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
          );
        },
      ),
    );
  }
}
