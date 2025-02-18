import 'package:flutter/material.dart';

class PhoneSigninButton extends StatelessWidget {
  const PhoneSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full width of the screen
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white, // Text color
          elevation: 2,
        ),
        onPressed: () {
          Navigator.pushNamed(
              context, '/phone-number'); // Navigate to PhoneNumberScreen
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align content to start
          children: [
            Image.asset(
              "assets/icons/telephone.png",
              color: Colors.white,
              width: 27,
              height: 27,
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Phone',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
