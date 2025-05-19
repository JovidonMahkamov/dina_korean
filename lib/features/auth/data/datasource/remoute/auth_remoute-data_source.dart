import 'package:dina_korean_real/features/home/data/model/dashboard_model.dart';
import 'package:dina_korean_real/features/auth/data/model/log_in_user_model.dart';

abstract class AuthRemoteDataSource{
  Future<LogInUserModel> loginUser({
    required String email,
    required String password,
  });
}