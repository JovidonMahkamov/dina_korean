
import '../../domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  CourseModel({
    required int id,
    required String title,
    required String description,
    required String learning,
    required String requirements,
    required String level,
    required String language,
    required String category,
    required int oldPrice,
    required int currentPrice,
    required String previewImage,
    required bool published,
  }) : super(
    id: id,
    title: title,
    description: description,
    learning: learning,
    requirements: requirements,
    level: level,
    language: language,
    category: category,
    oldPrice: oldPrice,
    currentPrice: currentPrice,
    previewImage: previewImage,
    published: published,
  );

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      learning: json['learning'],
      requirements: json['requirements'],
      level: json['level'],
      language: json['language'],
      category: json['category'],
      oldPrice: json['oldPrice'],
      currentPrice: json['currentPrice'],
      previewImage: json['previewImage'],
      published: json['published'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'learning': learning,
      'requirements': requirements,
      'level': level,
      'language': language,
      'category': category,
      'oldPrice': oldPrice,
      'currentPrice': currentPrice,
      'previewImage': previewImage,
      'published': published,
    };
  }
}
