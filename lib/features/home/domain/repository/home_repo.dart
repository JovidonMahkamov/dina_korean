import 'package:dina_korean_real/features/online_lesson/domain/entities/profile.dart';
import 'package:dina_korean_real/features/home/domain/entities/result.dart';

import '../entities/dashboard_entity.dart';

abstract class HomeRepo{
  //home
  Future<DashboardEntity> getStatistics();
  Future<List<Result>> getResult();
}