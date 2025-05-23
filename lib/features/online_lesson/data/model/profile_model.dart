import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required String firstName,
    required String lastName,
    required String login,
    required String phone,
    required String telegramId,
    required String groupName,
    required List attendance,
  }) : super(
    firstName: firstName,
    lastName: lastName,
    login: login,
    phone: phone,
    telegramId: telegramId,
    groupName: groupName,
    attendance: attendance,
  );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return ProfileModel(
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      login: data['login'] ?? '',
      phone: data['phone'] ?? '',
      telegramId: data['telegram_id'] ?? '',
      groupName: data['group_name'] ?? '',
      attendance: json['attendance'] ?? []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'login': login,
      'phone': phone,
      'telegram_id': telegramId,
      'group_name': groupName,
    };
  }
}
