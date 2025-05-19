import 'package:dina_korean_real/features/home/domain/entities/profile.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';

class ProfileUseCase {
  final HomeRepo homeRepo;

  ProfileUseCase(this.homeRepo);

  Future<Profile> call() async {
    return await homeRepo.getProfile();
  }
}
