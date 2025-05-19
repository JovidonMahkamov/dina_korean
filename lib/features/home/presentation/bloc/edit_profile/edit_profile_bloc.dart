import 'package:dina_korean_real/features/home/domain/usecase/edit_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_event.dart';
import 'etid_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfilEvent, EditProfileState> {
  final EditProfileUseCase editProfileUseCase;

  EditProfileBloc(this.editProfileUseCase) : super(EditProfileInitial()) {
    on<EditProfilEvent>(_onUpdateProfile);
  }

  Future<void> _onUpdateProfile(EditProfilEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      await editProfileUseCase(event.profile);
      emit(EditProfileSuccess(event.profile));
    } catch (e) {
      emit(EditProfileError(message: e.toString()));
    }
  }
}
