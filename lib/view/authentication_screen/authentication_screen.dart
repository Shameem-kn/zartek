import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zartek/view/authentication_screen/widgets/google_signin_button.dart';
import 'package:zartek/view/authentication_screen/widgets/phone_signin_button.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.08),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * .23,
            ),
            SvgPicture.asset(
              "assets/icons/firebase.svg", // Ensure this file exists
              height: screenHeight * 0.2, // 20% of screen height
            ),
            SizedBox(height: screenHeight * 0.25), // 5% of screen height
            GoogleSigninButton(),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            PhoneSigninButton(),
          ],
        ),
      ),
    );
  }
}
