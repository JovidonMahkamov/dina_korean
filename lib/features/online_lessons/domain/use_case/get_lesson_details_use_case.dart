import 'package:dina_korean_real/features/online_lessons/domain/entities/lesson_details_entity.dart';

import '../repository/course_repo.dart';

class GetLessonDetailsUseCase {
  final CourseRepo courseRepo;

  GetLessonDetailsUseCase(this.courseRepo);

  Future<LessonDetailsEntity> call({required int lessonId}) {
    return courseRepo.getLessonDetail(lessonId: lessonId);
  }
}
