import 'package:dina_korean_real/features/online_lessons/presentation/bloc/user_cheek/user_cheek_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/course_repo.dart';
import '../course_event.dart';

class CheckAnswerBloc extends Bloc<CheckAnswerEvent, CheckAnswerState> {
  final CourseRepo courseRepo;

  CheckAnswerBloc({required this.courseRepo}) : super(CheckAnswerInitial()) {
    on<CheckAnswerEvent>((event, emit) async {
      emit(CheckAnswerLoading());
      try {
        final isCorrect = await courseRepo.postCheek(
          courseId: event.courseId,
          lessonId: event.lessonId,
          answer: event.answer.trim().toLowerCase(),
        );
        if (isCorrect) {
          emit(CheckAnswerCorrect());
        } else {
          emit(CheckAnswerIncorrect());
        }
      } catch (e) {
        print("CheckAnswerBloc error: $e");
        emit(CheckAnswerError());
      }
    });
  }
}