import 'package:dina_korean_real/features/online_lessons/data/model/course_model.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/lesson_details_entity.dart';

import '../../domain/entities/course_entity.dart';
import '../model/course_with_sections_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getCourse();

  Future<CourseWithSectionsModel> getCourseWithSections({
    required CourseEntity courseId,
  });

  Future<LessonDetailsEntity> getLessonDetail({required int lessonId});

  Future<CourseWithSectionsModel?> completeLesson({
    required int courseId,
    required int lessonId,
  });
}
