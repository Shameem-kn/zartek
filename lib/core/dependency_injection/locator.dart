import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartek/bloc/auth/auth_bloc.dart';
import 'package:zartek/repository/auth_api/auth_repo.dart';
import 'package:zartek/repository/auth_api/auth_repo_impl.dart';
import 'package:zartek/repository/user_pref/user_pref_repo.dart';

import '../../data/firebase_services/firebase_auth.dart';
import '../../repository/user_pref/user_pref_repo_impl.dart';

final getIt = GetIt.instance;

void setupLocator() async {
  // Register services
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

  // Register SharedPreferences (async initialization)
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Register repositories
  getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getIt<FirebaseAuthService>()));

  // Register UserPrefRepo
  getIt.registerLazySingleton<UserPrefRepo>(
      () => UserPrefRepoImpl(getIt<SharedPreferences>()));

  // Register BLoCs
  getIt.registerFactory<GoogleAuthBloc>(
      () => GoogleAuthBloc(getIt<AuthRepo>(), getIt<UserPrefRepo>()));
}
