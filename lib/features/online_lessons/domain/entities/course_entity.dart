class CourseEntity {
  final int id;
  final String title;
  final String description;
  final String learning;
  final String requirements;
  final String level;
  final String language;
  final String category;
  final int oldPrice;
  final int currentPrice;
  final String previewImage;
  final bool published;

  CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.learning,
    required this.requirements,
    required this.level,
    required this.language,
    required this.category,
    required this.oldPrice,
    required this.currentPrice,
    required this.previewImage,
    required this.published,
  });
}
