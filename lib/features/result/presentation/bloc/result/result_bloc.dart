import 'package:dina_korean_real/features/result/domain/use_case/result_use_case.dart';
import 'package:dina_korean_real/features/result/presentation/bloc/result/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../result_event.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final ResultUseCase resultUseCase;

  ResultBloc(this.resultUseCase) : super(ResultInitial()) {
    on<ResultE>(onLogInUser);
  }

  Future<void> onLogInUser(event, emit) async {
    emit(ResultLoading());
    try {
      final result = await resultUseCase();
      emit(ResultSuccess(result: result));
    } catch (e) {
      emit(ResultError(message: "Internet aloqasini tekshirin"));
    }
  }
}
