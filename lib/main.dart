import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import 'package:zartek/bloc/menu/menu_bloc.dart';
import 'package:zartek/core/dependency_injection/locator.dart';

import 'package:zartek/firebase_options.dart';
import 'package:zartek/core/routes/routes_name.dart';
import 'package:zartek/core/routes/route_paths.dart';
import 'package:zartek/bloc/auth/auth_bloc.dart';
import 'package:zartek/view/user_home_screen/user_home_screen.dart'; // Import your blocs

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator(); // Call service locator setup to register dependencies

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      ],
      child: MaterialApp(
        title: 'Zartek',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        // initialRoute: RoutePaths.authentication,
        // onGenerateRoute: Routes.generateRoute,
        home: UserHomeScreen(),
      ),
    );
  }
}
