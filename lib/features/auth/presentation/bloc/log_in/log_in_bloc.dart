
import 'dart:io';

import 'package:dina_korean_real/features/auth/presentation/bloc/log_in/log_in_state.dart';
import 'package:dio/dio.dart';
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
    } on DioException catch (e) {
      String errorMessage = _mapDioErrorToMessage(e);
      emit(LogInUserError( message: errorMessage));
    } catch (e) {
      emit(LogInUserError(message: "Noma’lum xato yuz berdi"));
    }
  }

  String _mapDioErrorToMessage(DioException error) {
    if (error.type == DioExceptionType.unknown &&
        error.error is SocketException) {
      return "Internet ulanmagan. Iltimos, tarmoqni tekshiring.";
    } else if (error.response?.statusCode == 401 || error.response?.statusCode ==404) {
      return "Login yoki parol noto‘g‘ri.";
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return "So‘rov vaqtida javob kelmadi. Keyinroq urinib ko‘ring.";
    } else if (error.response?.statusCode == 500) {
      return "Serverda nosozlik bor. Iltimos, keyinroq urinib ko‘ring.";
    }

    return "Noma’lum xato yuz berdi. Iltimos, qayta urinib ko‘ring.";
  }}