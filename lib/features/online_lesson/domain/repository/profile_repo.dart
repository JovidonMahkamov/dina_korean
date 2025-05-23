import '../entities/profile.dart';

abstract class ProfileRepo{
  Future<Profile> getProfile();
  Future<void> putProfileEdit(Profile profile);

}