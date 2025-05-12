abstract class AuthLocalDataSource{
//Remember me
Future<void>saveRememberMe(String email, String password);
Future<void> saveAuthToken(String token,);

}