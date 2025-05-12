import 'package:dina_korean_real/features/auth/data/datasource/local/auth_local_data_source.dart';
import 'package:hive_flutter/adapters.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource{
      final Box box;
      AuthLocalDataSourceImpl(this.box);

  @override
  Future<void> saveRememberMe(String email, String password) async{
    await box.put('email', email);
    await box.put('password', password);
  }

  @override
  Future<void> saveAuthToken(String token) async{
    await box.put('token', token);
  }
}