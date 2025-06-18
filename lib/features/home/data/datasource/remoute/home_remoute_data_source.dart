import 'package:dina_korean_real/features/result/data/model/result_model.dart';

import '../../model/dashboard_model.dart';

abstract class HomeRemouteDataSource{
  Future<DashboardModel> getStatistics();

}