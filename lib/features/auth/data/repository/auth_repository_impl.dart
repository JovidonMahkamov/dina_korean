import 'package:dina_korean_real/features/auth/domain/entities/log_in_user.dart';
import 'package:dina_korean_real/features/auth/domain/repository/log_in_user_repo.dart';

import '../datasource/remoute/auth_remoute-data_source.dart';

class AuthRepositoryImpl implements LogInUserRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<LogInUser> logIn({required String email, required String password}) {
    return authRemoteDataSource.loginUser(email: email, password: password);
  }
}
