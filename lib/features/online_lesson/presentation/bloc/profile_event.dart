import '../../domain/entities/profile.dart';

abstract class ProfileEvent{
  ProfileEvent();
}
class ProfileE extends ProfileEvent{
  ProfileE();
}
class EditProfilEvent extends ProfileEvent{
  final Profile profile;
  EditProfilEvent(this.profile);
}