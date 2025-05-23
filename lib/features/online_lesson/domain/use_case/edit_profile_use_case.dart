import 'package:dina_korean_real/features/online_lesson/domain/entities/profile.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';
import 'package:dina_korean_real/features/online_lesson/domain/repository/profile_repo.dart';

class EditProfileUseCase {
  final ProfileRepo profileRepo;

  EditProfileUseCase(this.profileRepo);

  Future<void> call(Profile profile) async {
    return await profileRepo.putProfileEdit(profile);
  }
}
