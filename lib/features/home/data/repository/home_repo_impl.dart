import 'package:dina_korean_real/features/home/domain/entities/dashboard_entity.dart';
import 'package:dina_korean_real/features/online_lesson/domain/entities/profile.dart';
import 'package:dina_korean_real/features/home/domain/entities/result.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';

import '../datasource/remoute/home_remoute_data_source.dart';
import '../../../online_lesson/data/model/profile_model.dart';

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

}
