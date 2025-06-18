import 'package:dina_korean_real/features/online_lessons/domain/entities/course_entity.dart';
import 'package:dina_korean_real/features/online_lessons/domain/repository/course_repo.dart';

class CourseUseCase {
  final CourseRepo courseRepo;

  CourseUseCase(this.courseRepo);

  Future<List<CourseEntity>> call() async {
    return await courseRepo.getCourse();
  }
}
