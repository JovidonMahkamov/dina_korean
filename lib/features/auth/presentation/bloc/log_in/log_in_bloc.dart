
import 'package:dina_korean_real/features/auth/presentation/bloc/log_in/log_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/log_in_user_use_case.dart';
import '../auth_event.dart';

class LogInUserBloc extends Bloc<AuthEvent, LogInUserState> {
  final LogInUserUseCase logInUseCase;

  LogInUserBloc(this.logInUseCase) : super(LogInUserInitial()) {
    on<LoginUser>(onLogInUser);
  }

  Future<void> onLogInUser(event, emit) async {
    emit(LogInUserLoading());
    try {
      final result = await logInUseCase(
        email: event.email,
        password: event.password,
      );
      emit(LogInUserSuccess(user: result));
    } catch (e) {
      emit(LogInUserError(message: e.toString()));
    }
  }
}
