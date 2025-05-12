import 'package:dina_korean_real/features/auth/domain/entities/log_in_user.dart';

abstract class LogInUserState {
  const LogInUserState();
}

class LogInUserInitial extends LogInUserState {}

class LogInUserLoading extends LogInUserState {}

class LogInUserSuccess extends LogInUserState {
  final LogInUser user;

  const LogInUserSuccess({required this.user});
}

class LogInUserError extends LogInUserState {
  final String message;

  const LogInUserError({required this.message});
}
