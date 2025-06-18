import 'package:dina_korean_real/features/online_lessons/domain/entities/course_entity.dart';

abstract class CourseState {
  const CourseState();
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseSuccess extends CourseState {
  final List<CourseEntity> course;

  const CourseSuccess({required this.course});
}

class CourseError extends CourseState {
  final String message;

  const CourseError({required this.message});
}
