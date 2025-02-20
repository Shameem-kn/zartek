import 'package:flutter/material.dart';
import 'package:zartek/core/color/color.dart';

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
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          elevation: 2,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/phone-number');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/telephone.png",
              color: AppColors.white,
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
