import 'package:dina_korean_real/features/auth/domain/repository/log_in_user_repo.dart';
import 'package:dina_korean_real/features/home/data/datasource/remoute/home_remoute_data_source_impl.dart';
import 'package:dina_korean_real/features/home/data/repository/home_repo_impl.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';
import 'package:dina_korean_real/features/home/domain/usecase/dashboard_use_case.dart';
import 'package:dina_korean_real/features/home/domain/usecase/edit_profile_use_case.dart';
import 'package:dina_korean_real/features/home/domain/usecase/profile_use_case.dart';
import 'package:dina_korean_real/features/home/domain/usecase/result_use_case.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/result/result_bloc.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/statistic/statistic_bloc.dart';
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
import '../../features/home/data/datasource/remoute/home_remoute_data_source.dart';

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

  //Home
  sl.registerLazySingleton<HomeRemouteDataSource>(
    () => HomeRemouteDataSourceImpl(sl()),
  );

  //! Repositories
  // * Auth
  sl.registerLazySingleton<LogInUserRepo>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );
  //Home
  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(homeRemouteDataSource: sl()),
  );

  //! Use cases
  // * Auth
  sl.registerLazySingleton(() => LogInUserUseCase(sl()));
  //Home
  sl.registerLazySingleton(() => DashboardUseCase(sl()));
  sl.registerLazySingleton(()=>ResultUseCase(sl()));
  sl.registerLazySingleton(()=>ProfileUseCase(sl()));
  sl.registerLazySingleton(()=>EditProfileUseCase(sl()));
  //! Bloc
  // * Auth
  sl.registerLazySingleton(() => LogInUserBloc(sl()));
  //Home
  sl.registerLazySingleton(() => StatisticBloc(sl()));
  sl.registerLazySingleton(() => ResultBloc(sl()));
  sl.registerLazySingleton(() => ProfileBloc(sl()));
  sl.registerLazySingleton(() => EditProfileBloc(sl()));
}
