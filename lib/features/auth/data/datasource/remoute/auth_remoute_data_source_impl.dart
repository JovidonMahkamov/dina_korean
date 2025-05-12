import 'package:dina_korean_real/features/auth/data/model/log_in_user_model.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/untils/logger.dart';
import 'auth_remoute-data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient = DioClient();


  @override
  Future<LogInUserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.post(
        ApiUrls.login,
        data: {'login': email, 'password': password},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoggerService.info('Login successful: ${response.data}');
        return LogInUserModel.fromJson(response.data);
      } else {
        LoggerService.warning("Login failed: ${response.statusCode}");
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      LoggerService.error('Error during user login: $e');
      rethrow;
    }
  }
}