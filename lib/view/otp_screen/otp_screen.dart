import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zartek/core/routes/route_paths.dart';
import 'package:zartek/view/otp_screen/widget/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<OtpScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPinput(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity, // Full width
                height: 50, // Fixed height
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 25, 96, 26), // Dark Green Color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // After OTP verification, navigate to the UserHomeScreen
                    Navigator.pushNamed(context, RoutePaths.userHome);
                  },
                  child: Text(
                    "Verify OTP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
