import 'package:dina_korean_real/features/home/domain/usecase/result_use_case.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/home_event.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/result/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultBloc extends Bloc<HomeEvent, ResultState> {
  final ResultUseCase resultUseCase;

  ResultBloc(this.resultUseCase) : super(ResultInitial()) {
    on<ResultEvent>(onLogInUser);
  }

  Future<void> onLogInUser(event, emit) async {
    emit(ResultLoading());
    try {
      final result = await resultUseCase();
      emit(ResultSuccess(result: result));
    } catch (e) {
      emit(ResultError(message: e.toString()));
    }
  }
}
