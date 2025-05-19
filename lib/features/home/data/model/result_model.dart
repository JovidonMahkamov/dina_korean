
import 'package:dina_korean_real/features/home/domain/entities/result.dart';

class ResultModel extends Result {
  const ResultModel({
    required int id,
    required String img,
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
    id: id,
    img: img,
    type: type,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['_id'] is int ? json['_id'] : int.tryParse(json['_id'].toString()) ?? 0,
      img: json['img'] ?? '',
      type: json['type'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

}
