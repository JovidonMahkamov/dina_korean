import '../../../online_lesson/domain/entities/profile.dart';

abstract class HomeEvent {
  const HomeEvent();
}
class Statistic extends HomeEvent {

  const Statistic();
}
class ResultEvent extends HomeEvent {

  const ResultEvent();
}

