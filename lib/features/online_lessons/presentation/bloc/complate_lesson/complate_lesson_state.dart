import 'package:equatable/equatable.dart';

import '../../../domain/entities/course_with_sections_entity.dart';

abstract class CompleteLessonState extends Equatable {
  const CompleteLessonState();

  @override
  List<Object?> get props => [];
}

class CompleteLessonInitial extends CompleteLessonState {}

class CompleteLessonLoading extends CompleteLessonState {}

class CompleteLessonSuccess extends CompleteLessonState {
  final CourseWithSectionsEntity courseData;

  const CompleteLessonSuccess(this.courseData);

  @override
  List<Object?> get props => [courseData];
}

class CompleteLessonFailure extends CompleteLessonState {
  final String message;

  const CompleteLessonFailure(this.message);

  @override
  List<Object?> get props => [message];
}
