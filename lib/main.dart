import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import 'package:zartek/bloc/phone_auth/phone_auth_bloc.dart';
import 'package:zartek/bloc/cart/cart_bloc.dart';
import 'package:zartek/bloc/menu/menu_bloc.dart';

import 'package:zartek/core/dependency_injection/locator.dart';

import 'package:zartek/firebase_options.dart';
import 'package:zartek/core/routes/routes_name.dart';
import 'package:zartek/core/routes/route_paths.dart';
import 'package:zartek/bloc/google_auth/auth_bloc.dart';

import 'utils/screen_size_finder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator(); // Call service locator setup to register dependencies

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenSizeFinder(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<GoogleAuthBloc>(
          create: (context) => getIt<
              GoogleAuthBloc>(), // Accessing your BLoC through service locator
        ),
        BlocProvider<MenuBloc>(
          create: (context) =>
              getIt<MenuBloc>(), // Accessing your BLoC through service locator
        ),
        BlocProvider<CartBloc>(
          create: (context) =>
              getIt<CartBloc>(), // Accessing your BLoC through service locator
        ),
        BlocProvider<PhoneAuthBloc>(
          create: (context) => getIt<
              PhoneAuthBloc>(), // Accessing your BLoC through service locator
        ),
      ],
      child: MaterialApp(
        title: 'Zartek',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutePaths.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
