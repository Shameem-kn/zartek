import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartek/bloc/bloc/phone_auth_bloc.dart';
import 'package:zartek/bloc/google_auth/auth_bloc.dart';
import 'package:zartek/bloc/cart/cart_bloc.dart';
import 'package:zartek/repository/google_auth/google_auth_repo.dart';
import 'package:zartek/repository/google_auth/google_auth_repo_impl.dart';
import 'package:zartek/repository/menu_repo/menu_repo.dart';
import 'package:zartek/repository/user_pref/user_pref_repo.dart';

import '../../bloc/menu/menu_bloc.dart';
import '../../data/firebase_services/firebase_auth.dart';
import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';

import '../../repository/menu_repo/menu_repo_impl.dart';
import '../../repository/phone_auth/phone_auth_repo.dart';
import '../../repository/phone_auth/phone_auth_repo_impl.dart';
import '../../repository/user_pref/user_pref_repo_impl.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Register services
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

  // Register SharedPreferences (async initialization)
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Register network service
  getIt.registerLazySingleton<BaseApiServices>(() => NetworkApiService());

  // Register repositories
  getIt.registerLazySingleton<GoogleAuthRepo>(
      () => GoogleAuthRepoImpl(getIt<FirebaseAuthService>()));

  getIt.registerLazySingleton<PhoneAuthRepo>(
      () => PhoneAuthRepoImpl(getIt<FirebaseAuthService>()));

  getIt.registerLazySingleton<UserPrefRepo>(
      () => UserPrefRepoImpl(getIt<SharedPreferences>()));

  getIt.registerLazySingleton<MenuRepo>(
      () => MenuRepoImpl(getIt<BaseApiServices>()));

  // Register BLoCs
  getIt.registerFactory<GoogleAuthBloc>(() => GoogleAuthBloc(
      authRepo: getIt<GoogleAuthRepo>(), userPrefRepo: getIt<UserPrefRepo>()));

  getIt.registerFactory<MenuBloc>(() => MenuBloc(menuRepo: getIt<MenuRepo>()));

  getIt.registerFactory<CartBloc>(() => CartBloc());

  getIt.registerFactory<PhoneAuthBloc>(() => PhoneAuthBloc(
      phoneAuthRepo: getIt<PhoneAuthRepo>(),
      userPrefRepo: getIt<UserPrefRepo>()));
}
