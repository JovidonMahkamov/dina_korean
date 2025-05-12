import 'package:dina_korean_real/features/auth/domain/entities/log_in_user.dart';

abstract class LogInUserRepo {
  //LogIn
  Future<LogInUser> logIn({required String email, required String password});
}
