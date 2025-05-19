import 'package:dina_korean_real/features/home/domain/usecase/profile_use_case.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/home_event.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<HomeEvent, ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileBloc(this.profileUseCase) : super(ProfileInitial()) {
    on<ProfileEvent>(onLogInUser);
  }

  Future<void> onLogInUser(event, emit) async {
    emit(ProfileLoading());
    try {
      final result = await profileUseCase();
      emit(ProfileSuccess(profile: result));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
