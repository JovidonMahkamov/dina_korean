class StudentProgressEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String? groupName;
  final double progressPercentage;

  StudentProgressEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.groupName,
    required this.progressPercentage,
  });
}
