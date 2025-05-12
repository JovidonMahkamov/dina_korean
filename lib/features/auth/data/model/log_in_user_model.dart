import 'package:dina_korean_real/features/auth/domain/entities/log_in_user.dart';

class LogInUserModel extends LogInUser {
  LogInUserModel({
    required super.token,
    required super.role,
    required super.id,
  });

  factory LogInUserModel.fromJson(Map<String, dynamic> json) {
    return LogInUserModel(
      token: json['token'] ?? '',
      role: json['role'] ?? '',
      id: json['id'] ?? 0,
    );
  }
}
