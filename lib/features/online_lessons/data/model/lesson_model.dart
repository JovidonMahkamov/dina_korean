import 'package:dina_korean_real/features/online_lessons/data/model/user_progress_model.dart';

import '../../domain/entities/lesson_entity.dart';

class LessonModel extends LessonEntity {
  LessonModel({
    required super.id,
    required super.title,
     required super.userProgress,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['_id'],
      title: json['title'],
      userProgress: (json['userProgress'] as List<dynamic>)
          .map((e) => UserProgressModel.fromJson(e))
          .toList(),
    );
  }
}
