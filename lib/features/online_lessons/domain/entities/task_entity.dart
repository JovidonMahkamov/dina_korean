class TaskEntity {
  final int id;
  final String text;
  final String textUz;
  final String image;
  final int lessonId;

  const TaskEntity({
    required this.id,
    required this.text,
    required this.textUz,
    required this.image,
    required this.lessonId,
  });
}
