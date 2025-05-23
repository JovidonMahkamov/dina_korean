import 'package:dina_korean_real/features/online_lesson/domain/entities/profile.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';
import 'package:dina_korean_real/features/online_lesson/domain/repository/profile_repo.dart';

class ProfileUseCase {
  final ProfileRepo profileRepo;

  ProfileUseCase(this.profileRepo);

  Future<Profile> call() async {
    return await profileRepo.getProfile();
  }
}
