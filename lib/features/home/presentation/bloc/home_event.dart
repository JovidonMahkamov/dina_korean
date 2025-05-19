import '../../domain/entities/profile.dart';

abstract class HomeEvent {
  const HomeEvent();
}
class Statistic extends HomeEvent {

  const Statistic();
}
class ResultEvent extends HomeEvent {

  const ResultEvent();
}
class ProfileEvent extends HomeEvent{
  ProfileEvent();
}
class EditProfilEvent extends HomeEvent{
  final Profile profile;
  EditProfilEvent(this.profile);
}