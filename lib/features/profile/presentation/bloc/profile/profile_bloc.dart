import 'package:dina_korean_real/features/profile/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/profile_use_case.dart';
import '../profile_event.dart';

class ProfileBloc extends Bloc<ProfileE, ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileBloc(this.profileUseCase) : super(ProfileInitial()) {
    on<ProfileE>(onLogInUser);
  }

  Future<void> onLogInUser(event, emit) async {
    emit(ProfileLoading());
    try {
      final result = await profileUseCase();
      emit(ProfileSuccess(profile: result));
    } catch (e) {
      emit(ProfileError(message:"Internet aloqasini tekshirin"));
    }
  }
}
