import 'package:dina_korean_real/core/network/dio_client.dart';
import 'package:dina_korean_real/features/online_lessons/data/datasource/course_remote_data_source.dart';
import 'package:dina_korean_real/features/online_lessons/data/model/course_model.dart';
import 'package:dina_korean_real/features/online_lessons/data/model/course_with_sections_model.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/lesson_details_entity.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_urls.dart';
import '../../../../core/untils/logger.dart';
import '../../../auth/data/datasource/local/auth_local_data_source.dart';
import '../../domain/entities/course_entity.dart';
import '../model/lesson_details_model.dart';

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final DioClient dioClient = DioClient();
  final Dio dio = Dio();
  final AuthLocalDataSource authLocalDataSource;

  CourseRemoteDataSourceImpl(this.authLocalDataSource);

  @override
  Future<List<CourseModel>> getCourse() async {
    try {
      final response = await dioClient.get(ApiUrls.onlineCourses);
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoggerService.info('course successful: ${response.data}');
        return (response.data as List)
            .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        LoggerService.warning("course failed:${response.statusCode}");
        throw Exception('course failed: ${response.statusCode}');
      }
    } catch (e) {
      LoggerService.error('Error during user course: $e');
      rethrow;
    }
  }

  @override
  Future<CourseWithSectionsModel> getCourseWithSections({
    required CourseEntity courseId,
  }) async {
    try {
      final token = authLocalDataSource.getAuthToken();
      final response = await dio.get(
        'https://api.dinakorean.uz/dashboard-course/${courseId.id}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoggerService.info('statistics successful: ${response.data}');
        return CourseWithSectionsModel.fromJson(response.data);
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
  Future<LessonDetailsEntity> getLessonDetail({required int lessonId}) async {
    try {
      final token = authLocalDataSource.getAuthToken();
      final response = await dio.get(
        'https://api.dinakorean.uz/lesson/${lessonId}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoggerService.info('statistics successful: ${response.data}');
        return LessonDetailsModel.fromJson(response.data);
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
  Future<bool> postCheek({
    required int courseId,
    required int lessonId,
    required String answer,
  }) async {
    try {
      final token = authLocalDataSource.getAuthToken();
      final response = await dio.post(
        'https://api.dinakorean.uz/complete-lesson/$lessonId',
        data: {'courseId': courseId, 'answer': answer},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['isCorrect'] == true;
      } else {
        return false;
      }
    } catch (e) {
      LoggerService.error('Answer check failed: $e');
      return false;
    }
  }
}
