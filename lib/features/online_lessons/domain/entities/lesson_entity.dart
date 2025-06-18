import 'package:dina_korean_real/features/online_lessons/domain/entities/user_progress_entity.dart';

class LessonEntity {
  final int id;
  final String title;
  final List<UserProgressEntity> userProgress;


  LessonEntity({
    required this.id,
    required this.title,
    required this.userProgress,

  });
}
