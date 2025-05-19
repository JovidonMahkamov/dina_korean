import '../../domain/entities/student_progress_entity.dart';

class StudentProgressModel extends StudentProgressEntity {
  StudentProgressModel({
    required int id,
    required String firstName,
    required String lastName,
    required String? groupName,
    required double progressPercentage,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    groupName: groupName,
    progressPercentage: progressPercentage,
  );

  factory StudentProgressModel.fromJson(Map<String, dynamic> json) {
    return StudentProgressModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      groupName: json['group_name'],
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'group_name': groupName,
      'progressPercentage': progressPercentage,
    };
  }
}
