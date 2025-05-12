
import 'package:dina_korean_real/features/auth/domain/entities/log_in_user.dart';
import 'package:dina_korean_real/features/auth/domain/repository/log_in_user_repo.dart';

class LogInUserUseCase {
  final LogInUserRepo logInUserRepo;

  LogInUserUseCase(this.logInUserRepo);

  Future<LogInUser> call({required String email,required String password}) async {
    return await logInUserRepo.logIn(email: email, password: password);
  }
}