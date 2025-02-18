import 'package:flutter/material.dart';

import '../../view/authentication_screen/authentication_screen.dart';
import '../../view/checkout_screen/checkout_screen.dart';
import '../../view/otp_screen/otp_screen.dart';
import '../../view/phone_number_screen/phone_number_screen.dart';
import '../../view/user_home_screen/user_home_screen.dart';
import 'route_paths.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget screen;

    switch (settings.name) {
      case RoutePaths.authentication:
        screen = const AuthenticationScreen();
        break;
      case RoutePaths.otp:
        screen = const OtpScreen();
        break;
      case RoutePaths.phoneNumber:
        screen = const PhoneNumberScreen();
        break;
      case RoutePaths.userHome:
        screen = const UserHomeScreen();
        break;
      case RoutePaths.cart:
        screen = const CheckoutScreen();
        break;
      default:
        screen = const Scaffold(
          body: Center(
            child: Text('No route defined'),
          ),
        );
    }

    return MaterialPageRoute(builder: (_) => screen);
  }
}
