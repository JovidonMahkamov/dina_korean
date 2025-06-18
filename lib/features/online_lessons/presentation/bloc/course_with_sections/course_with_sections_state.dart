
import 'package:dina_korean_real/features/online_lessons/domain/entities/course_with_sections_entity.dart';

abstract class CourseWithSectionsState {
  const CourseWithSectionsState();
}

class CourseWithSectionInitial extends CourseWithSectionsState {}

class CourseWithSectionLoading extends CourseWithSectionsState {}

class CourseWithSectionSuccess extends CourseWithSectionsState {
  final CourseWithSectionsEntity courseWithSectionsEntity;

  const CourseWithSectionSuccess({required this.courseWithSectionsEntity});
}

class CourseWithSectionError extends CourseWithSectionsState {
  final String message;

  const CourseWithSectionError({required this.message});
}
