import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.text,
    required super.textUz,
    required super.image,
    required super.lessonId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      text: json['text'],
      textUz: json['textUz'],
      image: json['image'],
      lessonId: json['lessonId'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'text': text,
    'textUz': textUz,
    'image': image,
    'lessonId': lessonId,
  };
}
