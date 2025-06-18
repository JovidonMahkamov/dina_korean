import 'package:dina_korean_real/features/online_lessons/domain/use_case/get_lesson_details_use_case.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/lesson_detail/lesson_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../course_event.dart';

class LessonDetailBloc extends Bloc<CourseEvent, LessonDetailState> {
  final GetLessonDetailsUseCase getLessonDetailsUseCase;

  LessonDetailBloc(this.getLessonDetailsUseCase)
      : super(LessonDetailInitial()) {
    on<LessonDetailE>(_onLessonDetailE);
  }

  Future<void> _onLessonDetailE(LessonDetailE event, Emitter<LessonDetailState> emit) async {
    emit(LessonDetailLoading());
    try {
      final result = await getLessonDetailsUseCase(lessonId: event.lessonId);
      emit(LessonDetailSuccess(lessonDetailsEntity: result));
    } catch (e) {
      emit(LessonDetailError(message: "Internet aloqasini tekshirin"));
    }
  }
}
