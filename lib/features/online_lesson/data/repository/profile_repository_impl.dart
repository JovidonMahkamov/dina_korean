import 'package:dina_korean_real/features/online_lesson/data/datasource/profile_remote_data_source.dart';
import 'package:dina_korean_real/features/online_lesson/domain/entities/profile.dart';
import 'package:dina_korean_real/features/online_lesson/domain/repository/profile_repo.dart';

import '../model/profile_model.dart';

class ProfileRepositoryImpl extends ProfileRepo{
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl(this.profileRemoteDataSource);
  @override
  Future<Profile> getProfile() {
    return profileRemoteDataSource.getProfile();
  }

  @override
  Future<void> putProfileEdit(Profile profile) async {
    final model = ProfileModel(
      firstName: profile.firstName,
      lastName: profile.lastName,
      login: profile.login,
      phone: profile.phone,
      telegramId: profile.telegramId,
      groupName: profile.groupName,
      attendance: [],
    );
    return await profileRemoteDataSource.putProfileEdit(model);
  }

}