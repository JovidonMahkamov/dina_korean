import 'package:dina_korean_real/features/online_lessons/domain/entities/course_entity.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/course_with_sections_entity.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/lesson_details_entity.dart';
import 'package:dina_korean_real/features/online_lessons/domain/repository/course_repo.dart';
import '../datasource/course_remote_data_source.dart';

class CourseRepoImpl implements CourseRepo {
  final CourseRemoteDataSource courseRemoteDataSource;

  CourseRepoImpl({required this.courseRemoteDataSource});

  @override
  Future<List<CourseEntity>> getCourse() {
    return courseRemoteDataSource.getCourse();
  }

  @override
  Future<CourseWithSectionsEntity> getCourseWithSections({required CourseEntity courseId}) {
   return courseRemoteDataSource.getCourseWithSections(courseId: courseId);
  }

  @override
  Future<LessonDetailsEntity> getLessonDetail({required int lessonId}) {
    return courseRemoteDataSource.getLessonDetail(lessonId: lessonId);
  }

  @override
  Future<bool> postCheek({required int courseId, required int lessonId, required String answer})  {
    return courseRemoteDataSource.postCheek(courseId: courseId, lessonId: lessonId, answer: answer);
  }
}
