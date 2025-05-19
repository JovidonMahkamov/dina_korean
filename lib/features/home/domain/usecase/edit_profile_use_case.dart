import 'package:dina_korean_real/features/home/domain/entities/profile.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';

class EditProfileUseCase {
  final HomeRepo homeRepo;

  EditProfileUseCase(this.homeRepo);

  Future<void> call(Profile profile) async {
    return await homeRepo.putProfileEdit(profile);
  }
}
