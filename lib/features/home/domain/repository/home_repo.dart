import 'package:dina_korean_real/features/result/domain/entities/result.dart';

import '../entities/dashboard_entity.dart';

abstract class HomeRepo{
  //home
  Future<DashboardEntity> getStatistics();
}