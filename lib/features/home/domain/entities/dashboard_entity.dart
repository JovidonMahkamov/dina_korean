import 'package:dina_korean_real/features/home/domain/entities/student_progress_entity.dart';

class DashboardEntity {
  final int teachers;
  final int students;
  final int results;
  final int groups;
  final List<StudentProgressEntity> studentsWithProgress;

  DashboardEntity({
    required this.teachers,
    required this.students,
    required this.results,
    required this.groups,
    required this.studentsWithProgress,
  });
}
