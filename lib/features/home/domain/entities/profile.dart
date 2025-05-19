class Profile {
  final String firstName;
  final String lastName;
  final String login;
  final String phone;
  final String telegramId;
  final String groupName;
  final List attendance;

  const Profile({
    required this.firstName,
    required this.lastName,
    required this.login,
    required this.phone,
    required this.telegramId,
    required this.groupName,
    required this.attendance,
  });

  Profile copyWith({
    String? firstName,
    String? lastName,
    String? login,
    String? phone,
    String? telegramId,
  }) {
    return Profile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      login: login ?? this.login,
      phone: phone ?? this.phone,
      telegramId: telegramId ?? this.telegramId,
      groupName: "",
      attendance: [],
    );
  }
}
