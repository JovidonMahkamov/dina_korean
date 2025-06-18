import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/services.dart';
import 'features/auth/presentation/bloc/log_in/log_in_bloc.dart';
import 'features/home/presentation/bloc/statistic/statistic_bloc.dart';
import 'features/online_lessons/data/repository/course_repo_impl.dart';
import 'features/online_lessons/domain/repository/course_repo.dart';
import 'features/online_lessons/presentation/bloc/course_with_sections/course_with_sections_bloc.dart';
import 'features/online_lessons/presentation/bloc/lesson_detail/lesson_detail_bloc.dart';
import 'features/online_lessons/presentation/bloc/online_lesson/course_bloc.dart';
import 'features/online_lessons/presentation/bloc/user_cheek/user_cheek_bloc.dart';
import 'features/profile/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'features/result/presentation/bloc/result/result_bloc.dart';

class MyBlocProvider extends StatelessWidget {
  const MyBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CourseRepo>(create: (_) => CourseRepoImpl(courseRemoteDataSource: sl())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LogInUserBloc>(create: (context) => sl<LogInUserBloc>()),
          BlocProvider<StatisticBloc>(create: (context) => sl<StatisticBloc>()),
          BlocProvider<ResultBloc>(create: (context) => sl<ResultBloc>()),
          BlocProvider<ProfileBloc>(create: (context) => sl<ProfileBloc>()),
          BlocProvider<EditProfileBloc>(create: (context) => sl<EditProfileBloc>()),
          BlocProvider<CourseBloc>(create: (context) => sl<CourseBloc>()),
          BlocProvider<CourseWithSectionsBloc>(create: (context) => sl<CourseWithSectionsBloc>()),
          BlocProvider<LessonDetailBloc>(create: (context) => sl<LessonDetailBloc>()),
          BlocProvider<CheckAnswerBloc>(create: (context) => sl<CheckAnswerBloc>()),
        ],
        child: child,
      ),
    );
  }
}
