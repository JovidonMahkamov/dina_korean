import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/course_repo.dart';
import '../course_event.dart';
import 'complate_lesson_state.dart';

class CompleteLessonBloc extends Bloc<CourseEvent, CompleteLessonState> {
  final CourseRepo repo;

  CompleteLessonBloc({required this.repo}) : super(CompleteLessonInitial()) {
    on<CompleteLessonSubmitted>(_onCompleteLesson);
  }

  Future<void> _onCompleteLesson(
      CompleteLessonSubmitted event,
      Emitter<CompleteLessonState> emit,
      ) async {
    emit(CompleteLessonLoading());
    try {
      final result = await repo.completeLesson(
        courseId: event.courseId,
        lessonId: event.lessonId,
      );

      if (result != null) {
        emit(CompleteLessonSuccess(result));
      } else {
        emit(const CompleteLessonFailure("Darsni yakunlab bo‘lmadi"));
      }
    } catch (e) {
      emit(CompleteLessonFailure(e.toString()));
    }
  }
}
