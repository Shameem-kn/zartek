import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/bloc/auth/auth_bloc.dart';
import 'package:zartek/bloc/auth/auth_event.dart';
import 'package:zartek/bloc/auth/auth_state.dart';
import 'package:zartek/core/routes/route_paths.dart'; // Import the RoutePaths for easy access

class GoogleSigninButton extends StatelessWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
      listener: (context, state) {
        // Navigate to the UserHomeScreen when GoogleSignIn is successful
        if (state is GoogleAuthSuccessState) {
          // Navigate to UserHomeScreen using named route
          Navigator.pushNamed(
            context,
            RoutePaths.userHome, // Use the named route from RoutePaths
          );
        } else if (state is GoogleAuthFailedState) {
          // Optionally show a failure message when Google sign-in fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Google sign-in failed')),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity, // Full width of the screen
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white, // Text color
              elevation: 2,
            ),
            onPressed: state is GoogleAuthLoadingState
                ? null // Disable the button when loading
                : () {
                    print("Google sign-in triggered");
                    // Only call GoogleSignInRequested when not in loading state
                    context.read<GoogleAuthBloc>().add(GoogleSignInRequested());
                  },
            child: state is GoogleAuthLoadingState
                ? Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align content to start
                    children: [
                      SvgPicture.asset(
                        'assets/icons/google.svg', // Updated to use SVG
                        height: 27,
                        width: 27,
                      ),
                      Expanded(
                        child: Center(
                          // Centers the text in remaining space
                          child: Text(
                            'Google',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
