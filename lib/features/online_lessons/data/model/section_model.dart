import '../../domain/entities/section_entity.dart';
import 'lesson_model.dart';

class SectionModel extends SectionEntity {
  SectionModel({
    required super.id,
    required super.title,
    required super.lessons,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['_id'],
      title: json['title'],
      lessons: (json['lessonId'] as List)
          .map((e) => LessonModel.fromJson(e))
          .toList(),
    );
  }
}
