import 'package:dina_korean_real/features/auth/domain/repository/log_in_user_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import '../../features/auth/data/datasource/local/auth_local_data_source.dart';
import '../../features/auth/data/datasource/local/auth_local_remoute_data_source.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/auth/data/datasource/remoute/auth_remoute-data_source.dart';
import '../../features/auth/data/datasource/remoute/auth_remoute_data_source_impl.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/usecase/log_in_user_use_case.dart';
import '../../features/auth/presentation/bloc/log_in/log_in_bloc.dart';


final sl = GetIt.instance;

Future<void> setup() async {
  sl.registerLazySingleton(() => Dio());
  await Hive.initFlutter();
  await GetStorage.init();
  //! Hive
  final authBox = await Hive.openBox('authBox');
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(authBox),
  );



  //! Data sources
  // * Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(),
  );


  //! Repositories
  // * Auth
  sl.registerLazySingleton<LogInUserRepo>(
        () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );

  //! Use cases
  // * Auth
  sl.registerLazySingleton(() => LogInUserUseCase(sl()));

  //! Bloc
  // * Auth
  sl.registerLazySingleton(() => LogInUserBloc(sl()));


}
