import 'package:dina_korean_real/features/auth/domain/repository/log_in_user_repo.dart';
import 'package:dina_korean_real/features/home/data/repository/home_repo_impl.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';
import 'package:dina_korean_real/features/home/domain/usecase/dashboard_use_case.dart';
import 'package:dina_korean_real/features/online_lessons/data/datasource/course_remote_data_source.dart';
import 'package:dina_korean_real/features/online_lessons/data/datasource/course_remote_data_source_impl.dart';
import 'package:dina_korean_real/features/online_lessons/data/repository/course_repo_impl.dart';
import 'package:dina_korean_real/features/online_lessons/domain/repository/course_repo.dart';
import 'package:dina_korean_real/features/online_lessons/domain/use_case/course_use_case.dart';
import 'package:dina_korean_real/features/online_lessons/domain/use_case/get_course_with_sections_usecase.dart';
import 'package:dina_korean_real/features/online_lessons/domain/use_case/get_lesson_details_use_case.dart';
import 'package:dina_korean_real/features/online_lessons/domain/use_case/post_user_cheek.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/course_with_sections/course_with_sections_bloc.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/lesson_detail/lesson_detail_bloc.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/online_lesson/course_bloc.dart';
import 'package:dina_korean_real/features/result/data/datasource/remote/result_remote_data_source.dart';
import 'package:dina_korean_real/features/result/data/datasource/remote/result_remote_data_source_impl.dart';
import 'package:dina_korean_real/features/result/data/repository/result_repo_impl.dart';
import 'package:dina_korean_real/features/result/domain/repository/result_repo.dart';
import 'package:dina_korean_real/features/result/domain/use_case/result_use_case.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/statistic/statistic_bloc.dart';
import 'package:dina_korean_real/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:dina_korean_real/features/profile/data/datasource/profile_remote_data_source_impl.dart';
import 'package:dina_korean_real/features/profile/data/repository/profile_repository_impl.dart';
import 'package:dina_korean_real/features/profile/domain/repository/profile_repo.dart';
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
import '../../features/home/data/datasource/remoute/home_remoute_data_source_impl.dart';
import '../../features/online_lessons/presentation/bloc/user_cheek/user_cheek_bloc.dart';
import '../../features/profile/domain/use_case/edit_profile_use_case.dart';
import '../../features/profile/domain/use_case/profile_use_case.dart';
import '../../features/profile/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import '../../features/profile/presentation/bloc/profile/profile_bloc.dart';
import '../../features/result/presentation/bloc/result/result_bloc.dart';

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
  //Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );
  //Result
  sl.registerLazySingleton<ResultRemoteDataSource>(
    () => ResultRemoteDataSourceImpl(),
  );
  //Course
  sl.registerLazySingleton<CourseRemoteDataSource>(
    () => CourseRemoteDataSourceImpl(sl()),
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
  //Profile
  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepositoryImpl(sl()));
  //Result
  sl.registerLazySingleton<ResultRepo>(
    () => ResultRepoImpl(resultRemoteDataSource: sl()),
  );
  //Course
  sl.registerLazySingleton<CourseRepo>(
    () => CourseRepoImpl(courseRemoteDataSource: sl()),
  );

  //! Use cases
  // * Auth
  sl.registerLazySingleton(() => LogInUserUseCase(sl()));
  //Home
  sl.registerLazySingleton(() => DashboardUseCase(sl()));
  //Result
  sl.registerLazySingleton(() => ResultUseCase(sl()));
  //Profile
  sl.registerLazySingleton(() => ProfileUseCase(sl()));
  sl.registerLazySingleton(() => EditProfileUseCase(sl()));
  //Course
  sl.registerLazySingleton(() => CourseUseCase(sl()));
  sl.registerLazySingleton(() => GetCourseWithSectionsUseCase(sl()));
  sl.registerLazySingleton(() => GetLessonDetailsUseCase(sl()));
  sl.registerLazySingleton(()=> PostUserCheek(sl()));

  //! Bloc
  // * Auth
  sl.registerLazySingleton(() => LogInUserBloc(sl()));
  //Home
  sl.registerLazySingleton(() => StatisticBloc(sl()));
  //Result
  sl.registerLazySingleton(() => ResultBloc(sl()));
  //Profile
  sl.registerLazySingleton(() => ProfileBloc(sl()));
  sl.registerLazySingleton(() => EditProfileBloc(sl()));
  //Course
  sl.registerLazySingleton(() => CourseBloc(sl()));
  sl.registerLazySingleton(() => CourseWithSectionsBloc(sl()));
  sl.registerLazySingleton(() => LessonDetailBloc(sl()));
  sl.registerLazySingleton(()=> CheckAnswerBloc(courseRepo: sl()));
}
