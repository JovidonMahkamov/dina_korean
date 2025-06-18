import 'lesson_entity.dart';

class SectionEntity {
  final int id;
  final String title;
  final List<LessonEntity> lessons;

  SectionEntity({
    required this.id,
    required this.title,
    required this.lessons,
  });
}
