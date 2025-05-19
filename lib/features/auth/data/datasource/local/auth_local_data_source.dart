abstract class AuthLocalDataSource {
  Future<void> saveRememberMe(String email, String password);
  Future<void> saveAuthToken(String token);
  Future<void> saveUserId(int id);
  String? getEmail();
  String? getPassword();
  String? getAuthToken();
  int? getUserId();
  Future<void> clearAll();
}
