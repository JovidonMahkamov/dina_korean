import 'package:dina_korean_real/features/home/domain/usecase/dashboard_use_case.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/home_event.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/statistic/statistic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticBloc extends Bloc<HomeEvent, StatisticState> {
  final DashboardUseCase dashboardUseCase;

  StatisticBloc(this.dashboardUseCase) : super(StatisticInitial()) {
    on<Statistic>(onLogInUser);
  }

  Future<void> onLogInUser(event, emit) async {
    emit(StatisticLoading());
    try {
      final result = await dashboardUseCase();
      emit(StatisticSuccess(dashboardEntity: result));
    } catch (e) {
      emit(StatisticError(message: e.toString()));
    }
  }
}
