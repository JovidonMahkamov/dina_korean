import 'package:dina_korean_real/features/online_lessons/domain/entities/task_entity.dart';

class LessonDetailsEntity {
  final int id;
  final String title;
  final int position;
  final String videoUrl;
  final String dictionary;
  final String audioUrl;
  final int sectionId;
  final bool free;
  final bool isCompleted;
  final List<int> userProgress;
  final Duration duration;
  final List<TaskEntity> tasks;

  const LessonDetailsEntity({
    required this.id,
    required this.title,
    required this.position,
    required this.videoUrl,
    required this.dictionary,
    required this.audioUrl,
    required this.sectionId,
    required this.free,
    required this.isCompleted,
    required this.userProgress,
    required this.duration,
    required this.tasks,
  });
}
