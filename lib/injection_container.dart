import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/jugability/data/datasource/jugability_localdatasource.dart';
import 'features/jugability/domain/repositories/jugability_repository.dart';
import 'features/jugability/data/repositories/jugability_repository_imp.dart';
import 'features/jugability/presentation/bloc/jugability_bloc.dart';
import 'features/login/data/datasources/login_localdatasouce.dart';
import 'features/login/data/datasources/login_remotedatasource.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/login/domain/usecases/verify_box.dart' as verify_box;
import 'features/menu/presentation/bloc/menu_bloc.dart';
import 'features/jugability/domain/usecases/get_info_round.dart' as get_info_round;
import 'firebase_options.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature - Login
  // Bloc
  sl.registerFactory(() => LoginBloc(verifyDevice: sl()));

  // Use Cases
  sl.registerLazySingleton(() => verify_box.VerifyDevice(repository: sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
      ));

  // Data Sources
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl());
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());

  // ! Feature - Menu
  // Bloc
  sl.registerFactory(() => MenuBloc());

  // Use Cases

  // Repository

  // Data Sources

  // ! Feature - Jugability
  // Bloc
  sl.registerFactory(() => JugabilityBloc());

  // Use Cases
  sl.registerLazySingleton(() => get_info_round.GetInfoRound(repository: sl()));

  // Repository
  sl.registerLazySingleton<JugabilityRepository>(() => JugabilityRepositoryImpl(
        localDataSource: sl(),
        // remoteDataSource: sl(),
      ));

  // Data Sources
  sl.registerLazySingleton<JugabilityLocalDataSource>(
      () => JugabilityLocalDataSourceImpl());


  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  final firebase = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  sl.registerLazySingleton(() => firebase);

  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);

  final internetConnection = InternetConnection();
  sl.registerLazySingleton(() => internetConnection);
}
