import 'package:dina_korean_real/features/online_lessons/data/model/task_model.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/lesson_details_entity.dart';

class LessonDetailsModel extends LessonDetailsEntity {
  LessonDetailsModel({
    required super.id,
    required super.title,
    required super.position,
    required super.videoUrl,
    required super.dictionary,
    required super.audioUrl,
    required super.sectionId,
    required super.free,
    required super.isCompleted,
    required super.userProgress,
    required super.duration,
    required super.tasks,
  });

  factory LessonDetailsModel.fromJson(Map<String, dynamic> json) {
    final lesson = json['lesson'];
    final tasksJson = json['tasks'] as List<dynamic>;

    return LessonDetailsModel(
      id: lesson['_id'],
      title: lesson['title'],
      position: lesson['position'],
      videoUrl: lesson['videoUrl'],
      dictionary: lesson['dictionary'],
      audioUrl: lesson['audioUrl'],
      sectionId: lesson['sectionId'],
      free: lesson['free'],
      isCompleted: json['isCompleted'],
      userProgress: List<int>.from(lesson['userProgress']),
      duration: Duration(
        hours: lesson['duration']['hours'],
        minutes: lesson['duration']['minutes'],
        seconds: lesson['duration']['seconds'],
      ),
      tasks: tasksJson.map((e) => TaskModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'lesson': {
      '_id': id,
      'title': title,
      'position': position,
      'videoUrl': videoUrl,
      'dictionary': dictionary,
      'audioUrl': audioUrl,
      'sectionId': sectionId,
      'free': free,
      'userProgress': userProgress,
      'duration': {
        'hours': duration.inHours,
        'minutes': duration.inMinutes % 60,
        'seconds': duration.inSeconds % 60,
      },
    },
    'tasks': tasks.map((e) => (e as TaskModel).toJson()).toList(),
    'isCompleted': isCompleted,
  };
}
