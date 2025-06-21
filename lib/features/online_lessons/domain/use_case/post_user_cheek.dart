import '../entities/course_with_sections_entity.dart';
import '../repository/course_repo.dart';

class CompleteLessonUseCase {
  final CourseRepo repo;

  CompleteLessonUseCase(this.repo);

  Future<CourseWithSectionsEntity?> call({
    required int courseId,
    required int lessonId,
  }) {
    return repo.completeLesson(courseId: courseId, lessonId: lessonId);
  }
}
