import 'package:dina_korean_real/features/home/domain/entities/result.dart';

abstract class ResultState {
  const ResultState();
}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultSuccess extends ResultState {
  final List<Result> result;

  const ResultSuccess({required this.result});
}

class ResultError extends ResultState {
  final String message;

  const ResultError({required this.message});
}
