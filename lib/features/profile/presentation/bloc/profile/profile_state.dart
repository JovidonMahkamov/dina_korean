
import '../../../domain/entities/profile.dart';

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
