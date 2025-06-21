import 'package:dina_korean_real/features/online_lessons/domain/use_case/get_course_with_sections_usecase.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/course_with_sections/course_with_sections_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/post_user_cheek.dart';
import '../course_event.dart';

class CourseWithSectionsBloc extends Bloc<CourseEvent, CourseWithSectionsState> {
  final GetCourseWithSectionsUseCase courseWithSectionsUseCase;
  final CompleteLessonUseCase completeLessonUseCase;

  CourseWithSectionsBloc({
    required this.courseWithSectionsUseCase,
    required this.completeLessonUseCase,
  }) : super(CourseWithSectionInitial()) {
    on<CourseWithSectionE>(_onLoadCourse);
    on<CompleteLessonSubmitted>(_onCompleteLesson);
  }

  // Kursni yuklash
  Future<void> _onLoadCourse(CourseWithSectionE event, Emitter emit) async {
    emit(CourseWithSectionLoading());
    try {
      final result = await courseWithSectionsUseCase(courseId: event.courseId);
      emit(CourseWithSectionSuccess(courseWithSectionsEntity: result));
    } catch (e) {
      emit(CourseWithSectionError(message: "Internet aloqasini tekshiring"));
    }
  }

  // Darsni yakunlash
  Future<void> _onCompleteLesson(CompleteLessonSubmitted event, Emitter emit) async {
    print("✅ CompleteLessonSubmitted event triggered");
    emit(CourseWithSectionLoading());
    try {
      final result = await completeLessonUseCase(
        courseId: event.courseId,
        lessonId: event.lessonId,
      );
      if (result != null) {
        emit(CourseWithSectionSuccess(courseWithSectionsEntity: result));
      } else {
        emit(CourseWithSectionError(message: "Darsni yakunlashda xatolik yuz berdi"));
      }
    } catch (e) {
      emit(CourseWithSectionError(message: "Serverga ulanishda xatolik"));
    }
  }
}
