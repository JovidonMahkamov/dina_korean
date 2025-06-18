import '../../domain/entities/user_progress_entity.dart';

class UserProgressModel extends UserProgressEntity {
  UserProgressModel({required super.id, required super.lessonId});

  factory UserProgressModel.fromJson(Map<String, dynamic> json) =>
      UserProgressModel(id: json['_id'], lessonId: json['lessonId']);
}
