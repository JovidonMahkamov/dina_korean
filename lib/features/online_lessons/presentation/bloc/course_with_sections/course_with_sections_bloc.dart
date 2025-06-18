import 'package:dina_korean_real/features/online_lessons/domain/use_case/get_course_with_sections_usecase.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/course_with_sections/course_with_sections_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../course_event.dart';

class CourseWithSectionsBloc extends Bloc<CourseEvent, CourseWithSectionsState> {
  final GetCourseWithSectionsUseCase courseWithSectionsUseCase;

  CourseWithSectionsBloc(this.courseWithSectionsUseCase)
    : super(CourseWithSectionInitial()) {
    on<CourseWithSectionE>(onLogInUser);
  }

  Future<void> onLogInUser(event, emit) async {
    emit(CourseWithSectionLoading());
    try {
      final result = await courseWithSectionsUseCase(courseId: event.courseId);
      emit(CourseWithSectionSuccess(courseWithSectionsEntity: result));
    } catch (e) {
      emit(CourseWithSectionError(message: "Internet aloqasini tekshirin"));
    }
  }
}
