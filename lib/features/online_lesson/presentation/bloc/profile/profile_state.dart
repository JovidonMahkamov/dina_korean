import 'package:dina_korean_real/features/online_lesson/domain/entities/profile.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final Profile profile;

  const ProfileSuccess({required this.profile});
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});
}
