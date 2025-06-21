import 'package:dina_korean_real/features/online_lessons/domain/entities/course_entity.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/lesson_details_entity.dart';

import '../entities/course_with_sections_entity.dart';

abstract class CourseRepo{
  Future<List<CourseEntity>> getCourse();
  Future<CourseWithSectionsEntity> getCourseWithSections({required CourseEntity courseId});
  Future<LessonDetailsEntity> getLessonDetail({required int lessonId});
  Future<CourseWithSectionsEntity?> completeLesson({
    required int courseId,
    required int lessonId,
  });

}