
import '../entities/profile.dart';
import '../repository/profile_repo.dart';

class EditProfileUseCase {
  final ProfileRepo profileRepo;

  EditProfileUseCase(this.profileRepo);

  Future<void> call(Profile profile) async {
    return await profileRepo.putProfileEdit(profile);
  }
}
