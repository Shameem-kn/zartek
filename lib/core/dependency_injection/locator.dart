import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zartek/bloc/google_auth/auth_bloc.dart';
import 'package:zartek/bloc/cart/cart_bloc.dart';
import 'package:zartek/domain/repo_impl/google_auth_repo.dart';
import 'package:zartek/data/repository_impl/google_auth/google_auth_repo_impl.dart';
import 'package:zartek/domain/repo_impl/menu_repo.dart';
import 'package:zartek/domain/repo_impl/user_pref_repo.dart';

import '../../bloc/phone_auth/phone_auth_bloc.dart';
import '../../bloc/menu/menu_bloc.dart';
import '../../data/firebase_services/firebase_auth.dart';
import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';

import '../../data/repository_impl/menu_repo/menu_repo_impl.dart';
import '../../domain/repo_impl/phone_auth_repo.dart';
import '../../data/repository_impl/phone_auth/phone_auth_repo_impl.dart';
import '../../data/repository_impl/user_pref/user_pref_repo_impl.dart';

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

  // FIX: Inject UserPrefRepo into PhoneAuthBloc
  getIt.registerFactory<PhoneAuthBloc>(
      () => PhoneAuthBloc(getIt<UserPrefRepo>()));
}
