import 'package:hive/hive.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box box;
  AuthLocalDataSourceImpl(this.box);

  @override
  Future<void> saveRememberMe(String email, String password) async {
    await box.put('email', email);
    await box.put('password', password);
  }

  @override
  Future<void> saveAuthToken(String token) async {
    await box.put('token', token);
  }

  @override
  String? getEmail() => box.get('email');

  @override
  String? getPassword() => box.get('password');

  @override
  String? getAuthToken() => box.get('token');

  @override
  Future<void> clearAll() async {
    await box.clear();
  }

  @override
  int? getUserId() => box.get('id');



  @override
  Future<void> saveUserId(int id) async{
    await box.put('id', id);
  }
}
