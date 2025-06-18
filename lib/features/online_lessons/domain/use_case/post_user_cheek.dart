import '../repository/course_repo.dart';

class PostUserCheek {
  final CourseRepo courseRepo;

  PostUserCheek(this.courseRepo);

  Future<bool> call({required int courseId, required int lessonId, required String answer}) {
    return courseRepo.postCheek(courseId: courseId,lessonId: lessonId, answer: answer);
  }
}
