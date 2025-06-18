import 'package:dina_korean_real/features/online_lessons/domain/entities/course_entity.dart';

abstract class CourseEvent{
  CourseEvent();
}
class CourseE extends CourseEvent {

  CourseE();
}
class CourseWithSectionE extends CourseEvent{
  final CourseEntity courseId;
  CourseWithSectionE({required this.courseId});
}
class LessonDetailE extends CourseEvent{
  final int lessonId;
  LessonDetailE({required this.lessonId});
}
class CheckAnswerEvent extends CourseEvent {
  final int courseId;
  final int lessonId;
  final String answer;
  CheckAnswerEvent({required this.courseId, required this.lessonId, required this.answer});
}

