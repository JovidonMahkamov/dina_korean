import 'package:dina_korean_real/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/untils/logger.dart';
import '../../../auth/data/datasource/local/auth_local_data_source.dart';
import '../model/profile_model.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient = DioClient();
  final Dio dio = Dio();
  final AuthLocalDataSource authLocalDataSource;

  ProfileRemoteDataSourceImpl(this.authLocalDataSource);

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final token = authLocalDataSource.getAuthToken();
      final userId = authLocalDataSource.getUserId();
      final response = await dio.get(
        'https://api.dinakorean.uz/profile/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoggerService.info('statistics successful: ${response.data}');
        return ProfileModel.fromJson(response.data);
      } else {
        LoggerService.warning("statistics failed:${response.statusCode}");
        throw Exception('statistics failed: ${response.statusCode}');
      }
    } catch (e) {
      LoggerService.error('Error during user statistics: $e');
      rethrow;
    }
  }

  @override
  Future<void> putProfileEdit(ProfileModel profile) async {
    final token = authLocalDataSource.getAuthToken();

    final response = await dio.put(
      'https://api.dinakorean.uz/user-info',
      data: {
        "first_name": profile.firstName,
        "last_name": profile.lastName,
        "login": profile.login,
        "phone": profile.phone,
        "telegram_id": profile.telegramId,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      LoggerService.info("Profile updated: ${response.data}");
    } else {
      throw Exception('Profile update failed');
    }
  }
}
