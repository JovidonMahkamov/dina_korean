import 'package:dina_korean_real/features/online_lessons/domain/entities/lesson_details_entity.dart';

abstract class LessonDetailState {
  const LessonDetailState();
}

class LessonDetailInitial extends LessonDetailState {}

class LessonDetailLoading extends LessonDetailState {}

class LessonDetailSuccess extends LessonDetailState {
  final LessonDetailsEntity lessonDetailsEntity;

  const LessonDetailSuccess({required this.lessonDetailsEntity});
}

class LessonDetailError extends LessonDetailState {
  final String message;

  const LessonDetailError({required this.message});
}
