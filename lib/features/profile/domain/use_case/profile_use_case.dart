import '../entities/profile.dart';
import '../repository/profile_repo.dart';

class ProfileUseCase {
  final ProfileRepo profileRepo;

  ProfileUseCase(this.profileRepo);

  Future<Profile> call() async {
    return await profileRepo.getProfile();
  }
}
