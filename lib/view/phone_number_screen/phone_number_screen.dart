import 'package:flutter/material.dart';
import '../../core/routes/route_paths.dart';
import '../../utils/validator.dart'; // Import the validator file

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void sendOTP() {
    String phoneNumber = _phoneController.text;

    if (isValidPhoneNumber(phoneNumber)) {
      // Navigate to OTP screen and pass phone number
      Navigator.pushNamed(
        context,
        RoutePaths.otp,
        arguments: phoneNumber, // Pass the phone number to OTP screen
      );
    } else {
      // Show error in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid 10-digit phone number'),
          backgroundColor: Colors.red, // You can customize the SnackBar color
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Phone Number'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        // This centers the whole body content
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone, // Only shows number keypad
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  // autofocus: true, // Focus on the text field automatically
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: sendOTP,
                  child: Text(
                    'Get OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(double.infinity, 50), // Button width is full
                    backgroundColor: Colors.green, // Button color
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
