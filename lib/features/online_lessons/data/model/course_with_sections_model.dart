import '../../domain/entities/course_with_sections_entity.dart';
import 'course_model.dart';
import 'section_model.dart';

class CourseWithSectionsModel extends CourseWithSectionsEntity {
  CourseWithSectionsModel({
    required super.course,
    required super.sections,
    required super.progressPercentage,
  });

  factory CourseWithSectionsModel.fromJson(Map<String, dynamic> json) {
    return CourseWithSectionsModel(
      course: CourseModel.fromJson(json['course']),
      sections: (json['sections'] as List)
          .map((e) => SectionModel.fromJson(e))
          .toList(),
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
    );
  }
}
