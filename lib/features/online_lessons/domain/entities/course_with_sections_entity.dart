import 'course_entity.dart';
import 'section_entity.dart';

class CourseWithSectionsEntity {
  final CourseEntity course;
  final List<SectionEntity> sections;
  final double progressPercentage;

  CourseWithSectionsEntity({
    required this.course,
    required this.sections,
    required this.progressPercentage,
  });
}
