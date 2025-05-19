import '../../domain/entities/dashboard_entity.dart';
import '../../domain/entities/student_progress_entity.dart';
import 'student_progress_model.dart';

class DashboardModel extends DashboardEntity {
  DashboardModel({
    required int teachers,
    required int students,
    required int results,
    required int groups,
    required List<StudentProgressModel> studentsWithProgress,
  }) : super(
    teachers: teachers,
    students: students,
    results: results,
    groups: groups,
    studentsWithProgress: studentsWithProgress,
  );

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      teachers: json['teachers'],
      students: json['students'],
      results: json['results'],
      groups: json['groups'],
      studentsWithProgress: (json['studentsWithProgressPercentage'] as List)
          .map((e) => StudentProgressModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teachers': teachers,
      'students': students,
      'results': results,
      'groups': groups,
      'studentsWithProgressPercentage':
      studentsWithProgress.map((e) => (e as StudentProgressModel).toJson()).toList(),
    };
  }
}
