import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/services.dart';
import 'features/auth/presentation/bloc/log_in/log_in_bloc.dart';

class MyBlocProvider extends StatelessWidget {
  const MyBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LogInUserBloc>(create: (context) => sl<LogInUserBloc>()),
    ], child: child);
  }
}
