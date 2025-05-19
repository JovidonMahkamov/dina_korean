import 'package:dina_korean_real/features/home/domain/entities/dashboard_entity.dart';
import 'package:dina_korean_real/features/home/domain/entities/profile.dart';
import 'package:dina_korean_real/features/home/domain/entities/result.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';

import '../datasource/remoute/home_remoute_data_source.dart';
import '../model/profile_model.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemouteDataSource homeRemouteDataSource;

  HomeRepoImpl({required this.homeRemouteDataSource});

  @override
  Future<DashboardEntity> getStatistics() {
    return homeRemouteDataSource.getStatistics();
  }

  @override
  Future<List<Result>> getResult() {
    return homeRemouteDataSource.getResult();
  }

  @override
  Future<Profile> getProfile() {
    return homeRemouteDataSource.getProfile();
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
    return await homeRemouteDataSource.putProfileEdit(model);
  }
}
