import 'package:dina_korean_real/features/online_lessons/domain/use_case/course_use_case.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/course_event.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/online_lesson/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseUseCase courseUseCase;

  CourseBloc(this.courseUseCase) : super(CourseInitial()) {
    on<CourseE>(onLogInUser);
  }

  Future<void> onLogInUser(event, emit) async {
    emit(CourseLoading());
    try {
      final result = await courseUseCase();
      emit(CourseSuccess(course: result));
    } catch (e) {
      emit(CourseError(message: "Internet aloqasini tekshirin"));
    }
  }
}
