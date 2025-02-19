import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomPinput extends StatefulWidget {
  final TextEditingController pinController;
  const CustomPinput({super.key, required this.pinController});

  @override
  State<CustomPinput> createState() => _CustomPinputState();
}

class _CustomPinputState extends State<CustomPinput> {
  @override
  Widget build(BuildContext context) {
    // Default theme with square fields and rounded corners
    final PinTheme defaultPinTheme = PinTheme(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Rounded corners
        border:
            Border.all(color: Colors.black, width: 2), // Border color and width
      ),
      width: 50, // Square field size
      height: 50, // Square field size
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black, // Text color
      ),
    );

    // Focused theme with square fields and rounded corners
    final PinTheme focusedPinTheme = PinTheme(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Rounded corners
        border: Border.all(
            color: Colors.green, width: 2), // Border color when focused
      ),
      width: 50, // Square field size
      height: 50, // Square field size
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.green, // Text color when focused
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Pinput(
          length: 6, // Set the number of fields to 6
          controller: widget.pinController,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme, // Theme when focused
        ),
      ),
    );
  }
}
