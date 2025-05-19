import 'package:dina_korean_real/features/home/domain/entities/dashboard_entity.dart';

abstract class StatisticState {
  const StatisticState();
}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticSuccess extends StatisticState {
  final DashboardEntity dashboardEntity;

  const StatisticSuccess({required this.dashboardEntity});
}

class StatisticError extends StatisticState {
  final String message;

  const StatisticError({required this.message});
}
