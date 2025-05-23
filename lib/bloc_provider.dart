import 'package:dina_korean_real/features/home/presentation/bloc/result/result_bloc.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/statistic/statistic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/services.dart';
import 'features/auth/presentation/bloc/log_in/log_in_bloc.dart';
import 'features/online_lesson/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'features/online_lesson/presentation/bloc/profile/profile_bloc.dart';

class MyBlocProvider extends StatelessWidget {
  const MyBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LogInUserBloc>(create: (context) => sl<LogInUserBloc>()),
      BlocProvider<StatisticBloc>(create: (context) => sl<StatisticBloc>()),
      BlocProvider<ResultBloc>(create: (context) => sl<ResultBloc>()),
      BlocProvider<ProfileBloc>(create: (context) => sl<ProfileBloc>()),
      BlocProvider<EditProfileBloc>(create: (context) => sl<EditProfileBloc>()),
    ], child: child);
  }
}
