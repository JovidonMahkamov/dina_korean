
import '../../../domain/entities/profile.dart';

abstract class EditProfileState {
  const EditProfileState();
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final Profile updatedProfile;
  EditProfileSuccess(this.updatedProfile);
}

class EditProfileError extends EditProfileState {
  final String message;

  const EditProfileError({required this.message});
}
