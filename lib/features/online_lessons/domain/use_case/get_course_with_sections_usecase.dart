import '../entities/course_entity.dart';
import '../entities/course_with_sections_entity.dart';
import '../repository/course_repo.dart';

class GetCourseWithSectionsUseCase {
  final CourseRepo courseRepo;

  GetCourseWithSectionsUseCase(this.courseRepo);

  Future<CourseWithSectionsEntity> call({required CourseEntity courseId}) {
    return courseRepo.getCourseWithSections(courseId: courseId);
  }
}
